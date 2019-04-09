module Nri.Ui.SlideModal.V1 exposing
    ( Config, Panel
    , State, closed, open
    , view
    )

{-|

@docs Config, Panel
@docs State, closed, open
@docs view

-}

import Accessibility.Styled as Html exposing (..)
import Accessibility.Styled.Aria exposing (labelledBy)
import Accessibility.Styled.Role as Role
import Accessibility.Styled.Style
import Accessibility.Styled.Widget as Widget
import Css
import Css.Animations
import Css.Global
import Html.Styled
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Html.Styled.Keyed as Keyed
import Nri.Ui
import Nri.Ui.AssetPath exposing (Asset(..))
import Nri.Ui.Button.V8 as Button
import Nri.Ui.Colors.Extra
import Nri.Ui.Colors.V1 as Colors
import Nri.Ui.Fonts.V1 as Fonts
import Nri.Ui.Icon.V3 as Icon
import Nri.Ui.Text.V2 as Text


{-| -}
type alias Config msg =
    { panels : List (Panel msg)
    , height : Css.Vh
    , parentMsg : State -> msg
    }


{-| -}
type State
    = State (Maybe Int)


{-| Create the open state for the modal (the first panel will show).
-}
open : State
open =
    State (Just 0)


{-| Close the modal.
-}
closed : State
closed =
    State Nothing


{-| View the modal (includes the modal backdrop).
-}
view : Config msg -> State -> Html msg
view config state =
    case summarize state config.panels of
        Just summary ->
            viewBackdrop
                (viewModal config.height
                    (Maybe.map (viewPreviousPanel config.parentMsg) summary.previousPanel)
                    (viewPanels config.parentMsg summary)
                )

        Nothing ->
            Html.text ""


type alias Summary msg =
    { current : Panel msg
    , upcoming : List ( State, String )
    , previous : List ( State, String )
    , previousPanel : Maybe (Panel msg)
    }


summarize : State -> List (Panel msg) -> Maybe (Summary msg)
summarize (State state) panels =
    let
        indexedPanels =
            List.indexedMap
                (\i { title } -> ( State (Just i), title ))
                panels
    in
    case state of
        Just current ->
            case List.drop current panels of
                currentPanel :: rest ->
                    Just
                        { current = currentPanel
                        , previousPanel =
                            if current > 0 then
                                List.head (List.drop (current - 1) panels)

                            else
                                Nothing
                        , upcoming = List.drop (current + 1) indexedPanels
                        , previous = List.take current indexedPanels
                        }

                [] ->
                    Nothing

        Nothing ->
            Nothing


viewModal : Css.Vh -> Maybe ( String, List (Html msg) ) -> ( String, List (Html msg) ) -> Html msg
viewModal height previous ( labelledById, panel ) =
    Keyed.node "div"
        [ css
            [ Css.width (Css.px 600)
            , Css.padding4 (Css.px 35) Css.zero (Css.px 25) Css.zero
            , Css.margin2 (Css.px 75) Css.auto
            , Css.backgroundColor Colors.white
            , Css.borderRadius (Css.px 20)
            , Css.property "box-shadow" "0 1px 10px 0 rgba(0, 0, 0, 0.35)"
            ]
        , Role.dialog
        , Widget.modal True
        , labelledBy labelledById
        ]
        [ case previous of
            Just ( previousId, previousPanel ) ->
                ( previousId, div [ css [ animateOut ] ] previousPanel )

            Nothing ->
                ( "no-previous-panel", Html.text "" )
        , ( labelledById, panelContainer height FromRTL panel )
        ]


panelContainer : Css.Vh -> Direction -> List (Html msg) -> Html msg
panelContainer height direction panel =
    div
        [ css
            [ -- Layout
              Css.height height
            , Css.width (Css.px 600)
            , Css.minHeight (Css.px 360)
            , Css.maxHeight <| Css.calc (Css.vh 100) Css.minus (Css.px 100)

            -- Interior positioning
            , Css.displayFlex
            , Css.alignItems Css.center
            , Css.flexDirection Css.column
            , Css.flexWrap Css.noWrap

            -- Styles
            , Fonts.baseFont
            , animateIn direction
            ]
        ]
        panel


type Direction
    = FromRTL


animateIn : Direction -> Css.Style
animateIn direction =
    let
        ( start, end ) =
            case direction of
                FromRTL ->
                    ( Css.px 300, Css.zero )
    in
    Css.batch
        [ Css.animationDuration (Css.ms 300)
        , Css.property "animation-timing-function" "ease-in-out"
        , Css.animationName
            (Css.Animations.keyframes
                [ ( 0
                  , [ Css.Animations.transform [ Css.translateX start ]
                    , Css.Animations.opacity (Css.int 0)
                    ]
                  )
                , ( 100
                  , [ Css.Animations.transform [ Css.translateX end ]
                    , Css.Animations.opacity (Css.int 100)
                    ]
                  )
                ]
            )
        ]


animateOut : Css.Style
animateOut =
    Css.batch
        [ Css.position Css.absolute
        , Css.zIndex (Css.int -1)
        , Css.animationDuration (Css.ms 150)
        , Css.property "animation-timing-function" "ease-out"
        , Css.animationName
            (Css.Animations.keyframes
                [ ( 0
                  , [ Css.Animations.transform [ Css.translateX Css.zero ]
                    , Css.Animations.opacity (Css.int 100)
                    ]
                  )
                , ( 30, [ Css.Animations.opacity (Css.int 30) ] )
                , ( 100
                  , [ Css.Animations.transform [ Css.translateX (Css.px -100) ]
                    , Css.Animations.opacity (Css.int 0)
                    ]
                  )
                ]
            )
        ]


viewBackdrop : Html msg -> Html msg
viewBackdrop modal =
    Nri.Ui.styled div
        "modal-backdrop-container"
        (Css.backgroundColor (Nri.Ui.Colors.Extra.withAlpha 0.9 Colors.navy)
            :: [ Css.height (Css.vh 100)
               , Css.left Css.zero
               , Css.overflow Css.hidden
               , Css.position Css.fixed
               , Css.top Css.zero
               , Css.width (Css.pct 100)
               , Css.zIndex (Css.int 200)
               , Css.displayFlex
               , Css.alignItems Css.center
               , Css.justifyContent Css.center
               ]
        )
        []
        [ -- This global <style> node sets overflow to hidden on the body element,
          -- thereby preventing the page from scrolling behind the backdrop when the modal is
          -- open (and this node is present on the page).
          Css.Global.global [ Css.Global.body [ Css.overflow Css.hidden ] ]
        , modal
        ]


{-| Configuration for a single modal view in the sequence of modal views.
-}
type alias Panel msg =
    { icon : Html Never
    , title : String
    , content : Html msg
    , buttonLabel : String
    }


viewPanels : (State -> msg) -> Summary msg -> ( String, List (Html msg) )
viewPanels parentMsg ({ current } as summary) =
    ( panelId current
    , [ viewIcon current.icon
      , Text.subHeading
            [ span [ Html.Styled.Attributes.id (panelId current) ] [ Html.text current.title ]
            ]
      , viewContent current.content
      , viewFooter summary |> Html.map parentMsg
      ]
    )


viewPreviousPanel : (State -> msg) -> Panel msg -> ( String, List (Html msg) )
viewPreviousPanel parentMsg previousPanel =
    ( panelId previousPanel
    , [ viewIcon previousPanel.icon
      , Text.subHeading
            [ span [ Html.Styled.Attributes.id (panelId previousPanel) ] [ Html.text previousPanel.title ]
            ]
      , viewContent previousPanel.content
      ]
    )


panelId : Panel msg -> String
panelId { title } =
    "modal-header__" ++ String.replace " " "-" title


viewContent : Html msg -> Html msg
viewContent content =
    Nri.Ui.styled div
        "modal-content"
        [ Css.overflowY Css.auto
        , Css.padding2 (Css.px 30) (Css.px 45)
        , Css.width (Css.pct 100)
        , Css.marginBottom Css.auto
        , Css.boxSizing Css.borderBox
        ]
        []
        [ content ]


viewIcon : Html Never -> Html msg
viewIcon svg =
    div
        [ css
            [ Css.width (Css.px 100)
            , Css.height (Css.px 100)
            , Css.displayFlex
            , Css.alignItems Css.center
            , Css.justifyContent Css.center
            , Css.Global.children
                [ Css.Global.svg
                    [ Css.maxHeight (Css.px 100)
                    , Css.width (Css.px 100)
                    ]
                ]
            ]
        ]
        [ svg ]
        |> Html.map never


viewFooter : Summary msg -> Html State
viewFooter { previous, current, upcoming } =
    let
        nextPanel =
            List.head upcoming
                |> Maybe.map Tuple.first
                |> Maybe.withDefault closed
    in
    Nri.Ui.styled div
        "modal-footer"
        [ Css.displayFlex
        , Css.flexDirection Css.column
        , Css.alignItems Css.center
        , Css.margin4 (Css.px 20) Css.zero Css.zero Css.zero
        ]
        []
        [ viewFooterButton { label = current.buttonLabel, msg = nextPanel }
        , (List.map (uncurry Inactive) previous
            ++ Active
            :: List.map (uncurry InactiveDisabled) upcoming
          )
            |> List.map dot
            |> div [ css [ Css.marginTop (Css.px 16) ] ]
        ]


uncurry : (a -> b -> c) -> ( a, b ) -> c
uncurry f ( a, b ) =
    f a b


viewFooterButton : { label : String, msg : msg } -> Html msg
viewFooterButton { label, msg } =
    Button.button
        { onClick = msg
        , size = Button.Large
        , style = Button.Primary
        , width = Button.WidthExact 230
        }
        { label = label
        , state = Button.Enabled
        , icon = Nothing
        }


type Dot
    = Active
    | Inactive State String
    | InactiveDisabled State String


dot : Dot -> Html.Html State
dot type_ =
    let
        styles backgroundColor cursor =
            css
                [ Css.height (Css.px 10)
                , Css.width (Css.px 10)
                , Css.borderRadius (Css.px 5)
                , Css.margin2 Css.zero (Css.px 2)
                , Css.display Css.inlineBlock
                , Css.cursor cursor
                , Css.backgroundColor backgroundColor

                -- resets
                , Css.borderWidth Css.zero
                , Css.padding Css.zero
                , Css.hover [ Css.outline Css.none ]
                ]
    in
    case type_ of
        Active ->
            Html.div
                [ styles Colors.azure Css.auto
                ]
                []

        Inactive goTo title ->
            Html.button
                [ styles Colors.gray75 Css.pointer
                , onClick goTo
                ]
                [ span Accessibility.Styled.Style.invisible
                    [ text ("Go to " ++ title) ]
                ]

        InactiveDisabled goTo title ->
            Html.button
                [ styles Colors.gray75 Css.auto
                , Html.Styled.Attributes.disabled True
                ]
                [ span Accessibility.Styled.Style.invisible
                    [ text ("Go to " ++ title) ]
                ]
