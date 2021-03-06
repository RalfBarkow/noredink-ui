module Nri.Ui.Heading.V1 exposing
    ( Heading, heading
    , withVisualLevel, VisualLevel(..)
    , withDocumentLevel, DocumentLevel(..)
    , view
    )

{-| Headings with customization options for accessibility.


## Understanding spacing

  - All text styles have a specific line-height. This is set so that when text
    in the given style is long enough to wrap, the spacing between wrapped lines
    looks good.
  - No heading styles have padding.
  - **Heading styles** do not have margin. It is up to the caller to add
    appropriate margin to the layout.

@docs Heading, heading

@docs withVisualLevel, VisualLevel

@docs withDocumentLevel, DocumentLevel

@docs view

-}

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Nri.Ui.Colors.V1 exposing (..)
import Nri.Ui.Fonts.V1 as Fonts


{-| -}
type Heading msg
    = Heading (List (Html msg)) VisualLevel DocumentLevel


{-| start a heading. Render it with `view`.
-}
heading : List (Html msg) -> Heading msg
heading content =
    Heading content Top H1



-- VISUAL LEVEL


{-| -}
type VisualLevel
    = Top
    | Tagline
    | Subhead
    | Small


{-| Customize how the heading looks. The visual hierarchy should go Top ->
Tagline -> Subhead -> Small.

    heading [ text "Hello, World!" ]
        |> withVisualLevel Top
        |> view

-}
withVisualLevel : VisualLevel -> Heading msg -> Heading msg
withVisualLevel visualLevel (Heading content _ documentLevel) =
    Heading content visualLevel documentLevel


getStyles : VisualLevel -> Style
getStyles visualLevel =
    case visualLevel of
        Top ->
            headingStyles
                { font = Fonts.baseFont
                , color = navy
                , size = 30
                , lineHeight = 38
                , weight = 700
                }

        Tagline ->
            headingStyles
                { font = Fonts.baseFont
                , color = gray45
                , size = 20
                , lineHeight = 30
                , weight = 400
                }

        Subhead ->
            headingStyles
                { font = Fonts.baseFont
                , color = navy
                , size = 20
                , lineHeight = 26
                , weight = 700
                }

        Small ->
            Css.batch
                [ headingStyles
                    { font = Fonts.baseFont
                    , color = gray20
                    , size = 16
                    , lineHeight = 21
                    , weight = 700
                    }
                , letterSpacing (px -0.13)
                ]


headingStyles :
    { color : Color
    , font : Style
    , lineHeight : Float
    , size : Float
    , weight : Int
    }
    -> Style
headingStyles config =
    Css.batch
        [ config.font
        , fontSize (px config.size)
        , color config.color
        , lineHeight (px config.lineHeight)
        , fontWeight (int config.weight)
        , padding zero
        , textAlign left
        , margin zero
        ]



-- DOCUMENT LEVEL


{-| -}
type DocumentLevel
    = H1
    | H2
    | H3
    | H4
    | H5
    | H6


{-| Customize the document level of the heading. For accessibility reasons, you
should have exactly one H1, and only increase the level by one. You can use a
tool like [axe](https://www.deque.com/axe/) to check this.

    heading [ text "Hello, World!" ]
        |> withDocumentLevel H1
        |> view

-}
withDocumentLevel : DocumentLevel -> Heading msg -> Heading msg
withDocumentLevel documentLevel (Heading content visualLevel _) =
    Heading content visualLevel documentLevel


getTag : DocumentLevel -> (List (Attribute msg) -> List (Html msg) -> Html msg)
getTag documentLevel =
    case documentLevel of
        H1 ->
            h1

        H2 ->
            h2

        H3 ->
            h3

        H4 ->
            h4

        H5 ->
            h5

        H6 ->
            h6



-- VIEW


{-| render a Heading to Html. See the other docs in this module for
customizations.
-}
view : Heading msg -> Html msg
view (Heading content visualLevel documentLevel) =
    getTag documentLevel
        [ css [ getStyles visualLevel ] ]
        content
