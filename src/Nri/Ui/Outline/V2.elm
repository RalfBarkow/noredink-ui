module Nri.Ui.Outline.V2 exposing
    ( segment
    , node
    , NodeLayout
    , NodeConfig
    , config
    , html
    )

{-| A module for rendering outline layouts.

@docs segment
@docs node
@docs NodeLayout
@docs NodeConfig
@docs config
@docs html

-}

import Css
import Css.Global exposing (Snippet, children, descendants, everything, selector)
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes as Attributes
import Nri.Ui.Colors.V1 as Colors
import Nri.Ui.Effects.V1
import Nri.Ui.Fonts.V1 as Fonts
import Nri.Ui.Palette.V1 exposing (Palette)


{-| A wrapper for a node rendered into Html. This type exists to prevent us
from accidentally wrapping a node in a container element before passing it as a
child to another node or segment. Such wrapping would break some of our
styling, which assumes nodes of the same level are sibblings in the Html tree.
-}
type NodeLayout msg
    = NodeLayout (Html msg)


{-| A container to draw nodes in.

    segment
        [ node { config | label = "First Node" }
        , node { config | label = "Second Node" }
        ]

-}
segment : List (NodeLayout msg) -> Html msg
segment children =
    Html.styled Html.div
        [ segmentStyles ]
        [ Attributes.attribute "data-is-segment" "" ]
        (List.map unlayout children)


{-| Wrap any html in a NodeLayout so you can use it as sibling content to nodes.

    segment
        [ node { config | label = "This is a node" }
        , html (Html.text "This is some random Html content!")
        ]

-}
html : Html msg -> NodeLayout msg
html child =
    Html.div
        [ Attributes.attribute "data-is-custom-html" "" ]
        [ child ]
        |> NodeLayout


{-| Defines how a node should look.
-}
type alias NodeConfig msg =
    -- The node's label.
    { label : Html msg

    -- The content of the node (the part in the colored area).
    , contents : Html msg

    -- Child nodes (and other content) to be placed below the content.
    , children : List (NodeLayout msg)

    -- The node is selected. Draw a selection shadow around it.
    , selected : Bool

    -- The node is ghosted. Fade it out.
    , ghosted : Bool

    -- Addition attributes to be set on the top level node element.
    , attrs : List (Html.Attribute msg)
    }


{-| A default node configuration, allowing you to only set the properties you care about.

    node { config | label = "Claim" }

-}
config : NodeConfig msg
config =
    { label = Html.text ""
    , contents = Html.text ""
    , children = []
    , selected = False
    , ghosted = False
    , attrs = []
    }


{-| Draw a node of an outline structure. You can draw other nodes inside it and
connecting lines will appear.

    node { config | label = "Claim" }

-}
node : NodeConfig msg -> NodeLayout msg
node { label, contents, children, selected, attrs, ghosted } =
    NodeLayout <|
        -- We use a custom Html tag name here, to ensure we can find the first and
        -- last node in a last-of-type selector.
        Html.styled (Html.node "outline-node")
            [ nodeStyles
            , if ghosted then
                ghostedNodeStyles

              else
                Css.batch []
            ]
            (Attributes.attribute "data-is-node" "" :: attrs)
            [ Html.styled Html.div
                [ innerNodeStyles
                , if selected then
                    selectedNodeStyles

                  else
                    Css.batch []
                ]
                [ Attributes.attribute "data-is-inner-node" "" ]
                (Html.styled Html.div [ labelStyles ] [ Attributes.attribute "data-is-label" "" ] [ label ]
                    :: Html.styled Html.div [ contentsStyles ] [ Attributes.attribute "data-is-contents" "" ] [ contents ]
                    :: List.map unlayout children
                )
            ]


unlayout : NodeLayout msg -> Html msg
unlayout (NodeLayout html_) =
    html_


type Style
    = Segment
    | Node
    | InnerNode
    | SelectedNode
    | GhostedNode
    | Label
    | Contents
    | CustomHtml


labelHeight : Float
labelHeight =
    35


segmentStyles : Css.Style
segmentStyles =
    Css.batch
        [ Css.position Css.relative
        , Css.zIndex (Css.int 0)

        -- The overflow property cuts of connecting lines extending from
        -- top level nodes.
        , Css.overflow Css.auto
        ]


nodeStyles : Css.Style
nodeStyles =
    Css.batch
        -- The node's relative positioning allows the connecting line to
        -- point upward relative from the node's bounding box.
        [ Css.position Css.relative
        , Css.display Css.block

        -- This selects all nodes on a level but the first.
        , Css.Global.generalSiblings
            [ Css.Global.selector "[data-is-node]"
                -- Add some spacing between nodes of the same level.
                [ Css.marginTop (Css.px 20)
                , Css.before
                    [ Css.property "content" "''"
                    , Css.borderLeft2 (Css.px 1) Css.solid
                    , Css.batch lineStyles
                    ]
                ]
            ]

        -- Child nodes have a connecting line and are indented.
        , Css.Global.descendants
            [ Css.Global.selector "[data-is-node]"
                [ Css.marginTop (Css.px 20)
                , Css.before
                    -- Draw the connect line. It is like an antenna pointing
                    -- upward in the direction of the parent node.
                    [ Css.property "content" "''"
                    , Css.borderLeft2 (Css.px 1) Css.solid
                    , Css.borderBottom2 (Css.px 1) Css.solid
                    , Css.batch lineStyles
                    ]
                , Css.Global.children
                    -- Indent this node relative to the parent.
                    [ Css.Global.selector "[data-is-inner-node]"
                        [ Css.marginLeft (Css.px 50)
                        ]
                    ]
                ]
            , Css.Global.selector "[data-is-custom-html]"
                [ Css.marginLeft (Css.px 50)
                ]
            ]

        -- 1. Root level nodes are connected with one another using straight lines,
        --    so they are never curved.
        --
        --        Root Node 1
        --         │
        --        Root Node 2
        --
        -- 2. Second level nodes have a curved line when they are the last node of
        --    their level, and if their parent is the last root node. If either
        --    case is not true, they are connected to a straight line that
        --    continues beneath then. This is illustrated in the diagram below. As
        --    you can see only 'Child Node 3' should have a curved connecting line.
        --
        --        Root Node 1
        --         │
        --         ├─ Child Node 1
        --         │
        --        Root Node 2
        --         │
        --         ├─ Child Node 2
        --         │
        --         ╰─ Child Node 3
        --
        , Css.lastOfType
            [ Css.Global.descendants
                [ Css.Global.selector "[data-is-node]"
                    [ Css.lastOfType
                        [ Css.before
                            [ Css.borderRadius (Css.px 8)
                            ]
                        ]
                    ]
                ]
            ]

        -- 3. Third and lower level nodes always have a curved line when they are
        --    the last node on their level. This is illustrated in the diagram
        --    below. Sub-Child Node 2 has a curved connecting line, even though it's
        --    parent node is not the last node on its level.
        --
        --        Root Node
        --         │
        --         ├─ Child Node 1
        --         │   │
        --         │   ├─ Sub-Child Node 1
        --         │   │
        --         │   ╰─ Sub-Child Node 2
        --         │
        --         ╰─ Child Node 2
        --
        , Css.Global.descendants
            [ Css.Global.selector "[data-is-node]"
                [ Css.Global.descendants
                    [ Css.Global.selector "[data-is-node]"
                        [ Css.lastOfType
                            [ Css.before
                                [ Css.borderRadius (Css.px 8)
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


innerNodeStyles : Css.Style
innerNodeStyles =
    Css.batch
        [ Css.overflow Css.auto

        -- The position and zIndex create a new stacking context. Connecting
        -- lines in child nodes of this one will be drawn in this context.
        , Css.position Css.relative
        , Css.zIndex (Css.int 0)

        -- Recursively assign color styles to the different nested levels of
        -- the outline structure.
        , Css.Global.descendants
            (colorStyles
                [ Nri.Ui.Palette.V1.cornflower
                , Nri.Ui.Palette.V1.aqua
                , Nri.Ui.Palette.V1.turquoise
                , Nri.Ui.Palette.V1.green
                ]
            )
        ]


ghostedNodeStyles : Css.Style
ghostedNodeStyles =
    Css.batch
        [ Css.opacity (Css.num 0.5)
        , Css.zIndex (Css.int -1)
        , Css.position Css.relative
        ]


labelStyles : Css.Style
labelStyles =
    Css.batch
        [ Css.border2 (Css.px 1) Css.solid
        , Css.padding2 Css.zero (Css.px 15)
        , Css.fontSize (Css.px 15)
        , Css.borderRadius (Css.px labelHeight)
        , Css.lineHeight (Css.px (labelHeight - 3))
        , Css.height (Css.px labelHeight)
        , Css.backgroundColor Colors.white
        , Css.position Css.absolute
        , Css.boxSizing Css.borderBox
        , Css.top Css.zero
        , Css.left Css.zero
        , Css.fontSize (Css.px 15)
        , Fonts.baseFont
        , Css.color Colors.gray20
        , Css.fontWeight Css.bold
        ]


contentsStyles : Css.Style
contentsStyles =
    Css.batch
        [ Css.borderRadius (Css.px 8)
        , Css.marginTop (Css.px (labelHeight / 2))
        , Css.marginLeft (Css.px (labelHeight / 2))
        , Css.minHeight (Css.px 70)

        -- Ensure there's some margin on all sides, so we have the option of
        -- drawing a border around selected contents without it being cut of
        -- by the surrounding inner node.
        , Css.marginRight (Css.px 5)
        , Css.marginBottom (Css.px 5)
        ]


selectedNodeStyles : Css.Style
selectedNodeStyles =
    Css.batch
        [ Css.Global.children
            [ Css.Global.selector "[data-is-contents]"
                [ Css.batch Nri.Ui.Effects.V1.selectionShadow
                ]
            ]
        ]


colorStyles : List Palette -> List Snippet
colorStyles palettes =
    case palettes of
        [] ->
            []

        palette :: rest ->
            [ Css.Global.selector "[data-is-inner-node]"
                [ Css.Global.descendants (colorStyles rest)
                ]
            , Css.Global.selector "[data-is-contents]"
                [ Css.backgroundColor palette.background
                ]
            , Css.Global.selector "[data-is-label]"
                [ Css.color palette.primary
                , Css.borderColor palette.border
                ]
            ]


lineStyles : List Css.Style
lineStyles =
    [ Css.display Css.block
    , Css.borderColor Colors.gray75
    , Css.position Css.absolute
    , Css.width (Css.px 30)
    , Css.left (Css.px 30)
    , Css.bottom (Css.calc (Css.pct 100) Css.minus (Css.px (labelHeight / 2)))

    -- Ensure the connecting line is long enough. The containing element will
    -- cut it to size.
    , Css.height (Css.vh 10000)

    -- Make the connecting line go beneath the parent node,
    -- giving the impression it stops when touching the
    -- parent.
    , Css.zIndex (Css.int -100)
    ]
