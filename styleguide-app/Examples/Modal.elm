module Examples.Modal exposing (Msg, State, example, init, update, subscriptions)

{-|

@docs Msg, State, example, init, update, subscriptions

-}

import Accessibility.Styled as Html exposing (Html, div, h3, h4, p, text)
import Css exposing (..)
import Html.Styled.Attributes exposing (css)
import ModuleExample exposing (Category(..), ModuleExample)
import Nri.Ui.Checkbox.V5 as Checkbox
import Nri.Ui.Colors.V1 as Colors
import Nri.Ui.Modal.V5 as Modal


{-| -}
type alias State =
    { infoModal : Modal.Model
    , warningModal : Modal.Model
    , visibleTitle : Bool
    , showX : Bool
    , showContinue : Bool
    }


{-| -}
init : State
init =
    { infoModal = Modal.init
    , warningModal = Modal.init
    , visibleTitle = True
    , showX = True
    , showContinue = True
    }


{-| -}
example : (Msg -> msg) -> State -> ModuleExample msg
example parentMessage state =
    { name = "Nri.Ui.Modal.V5"
    , category = Modals
    , content =
        [ h4 [] [ text "Settings" ]
        , Checkbox.viewWithLabel
            { identifier = "visible-title"
            , label = "Visible title"
            , selected = Checkbox.selectedFromBool state.visibleTitle
            , setterMsg = SetVisibleTitle
            , disabled = False
            , theme = Checkbox.Square
            }
        , Checkbox.viewWithLabel
            { identifier = "show-x"
            , label = "Show X button"
            , selected = Checkbox.selectedFromBool state.showX
            , setterMsg = SetShowX
            , disabled = False
            , theme = Checkbox.Square
            }
        , Checkbox.viewWithLabel
            { identifier = "show-continue"
            , label = "Show Continue button"
            , selected = Checkbox.selectedFromBool state.showContinue
            , setterMsg = SetShowContinue
            , disabled = False
            , theme = Checkbox.Square
            }
        , h4 [] [ text "Modals" ]
        , Modal.info
            { launchButton =
                Modal.launchButton [] "Launch Info Modal"
                    |> Html.map InfoModalMsg
                    |> Just
            , title =
                Modal.viewTitle
                    { title = "Modal.info"
                    , visibleTitle = state.visibleTitle
                    }
            , content = viewContent InfoModalMsg state
            }
            state.infoModal
        , Modal.warning
            { launchButton =
                Modal.launchButton [] "Launch Warning Modal"
                    |> Html.map WarningModalMsg
                    |> Just
            , title =
                Modal.viewTitle
                    { title = "Modal.warning"
                    , visibleTitle = state.visibleTitle
                    }
            , content = viewContent WarningModalMsg state
            }
            state.warningModal
        ]
            |> List.map (Html.map parentMessage)
    }


viewContent : (Modal.Msg -> Msg) -> State -> Html Msg
viewContent wrapMsg state =
    div [] <|
        case ( state.showX, state.showContinue ) of
            ( True, True ) ->
                [ Modal.closeButton Modal.LastFocusableElement
                    |> Html.map wrapMsg
                , Modal.viewContent [ text "This is where the content goes!" ]
                , Modal.viewFooter
                    [ Modal.primaryButton Modal.FirstFocusableElement
                        ForceClose
                        "Continue"
                    ]
                ]

            ( True, False ) ->
                [ Modal.closeButton Modal.OnlyFocusableElement
                    |> Html.map wrapMsg
                , Modal.viewContent [ text "This is where the content goes!" ]
                ]

            ( False, True ) ->
                [ Modal.viewContent [ text "This is where the content goes!" ]
                , Modal.viewFooter
                    [ Modal.primaryButton Modal.OnlyFocusableElement
                        ForceClose
                        "Continue"
                    ]
                ]

            ( False, False ) ->
                [ Modal.viewContent [ text "This is where the content goes!" ]
                ]


{-| -}
type Msg
    = InfoModalMsg Modal.Msg
    | WarningModalMsg Modal.Msg
    | ForceClose
    | SetVisibleTitle Bool
    | SetShowX Bool
    | SetShowContinue Bool


{-| -}
update : Msg -> State -> ( State, Cmd Msg )
update msg state =
    case msg of
        InfoModalMsg modalMsg ->
            case Modal.update modalMsg state.infoModal of
                ( newState, cmds ) ->
                    ( { state | infoModal = newState }
                    , Cmd.map InfoModalMsg cmds
                    )

        WarningModalMsg modalMsg ->
            case Modal.update modalMsg state.warningModal of
                ( newState, cmds ) ->
                    ( { state | warningModal = newState }
                    , Cmd.map WarningModalMsg cmds
                    )

        ForceClose ->
            ( { state
                | infoModal = Modal.init
                , warningModal = Modal.init
              }
            , Cmd.none
            )

        SetVisibleTitle value ->
            ( { state | visibleTitle = value }, Cmd.none )

        SetShowX value ->
            ( { state | showX = value }, Cmd.none )

        SetShowContinue value ->
            ( { state | showContinue = value }, Cmd.none )


{-| -}
subscriptions : State -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map InfoModalMsg (Modal.subscriptions model.infoModal)
        , Sub.map WarningModalMsg (Modal.subscriptions model.warningModal)
        ]
