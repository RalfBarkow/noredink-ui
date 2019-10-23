module Nri.Ui.Modal.V8 exposing
    ( Model, init
    , Msg, update, subscriptions
    , open, close
    , info, warning
    , viewContent
    , Focusable
    , multipleFocusableElementView, onlyFocusableElementView
    , OptionalConfig
    , invisibleTitle
    , autofocusOnLastElement
    , closeButton
    )

{-| Changes from V7:

  - More customizable attributes

```
    import Html.Styled exposing (..)
    import Nri.Ui.Button.V9 as Button
    import Nri.Ui.Modal.V8 as Modal

    type Msg
        = ModalMsg Modal.Msg
        | DoSomething

    view : Modal.Model -> Html Msg
    view state =
        Modal.info
            { title = "Modal Header"
            , visibleTitle = True
            , wrapMsg = ModalMsg
            }
            [ Modal.onlyFocusableElementView
                (\{ onlyFocusableElement } visibleTitle ->
                    div []
                        [ Modal.viewContent {
                            , content = [ text "Content goes here!" ]
                            , footer =
                                [ Button.button "Continue"
                                    [ Button.primary
                                    , Button.onClick DoSomething
                                    , Button.custom onlyFocusableElement
                                    ]
                                , text "`onlyFocusableElement` will trap the focus on the 'Continue' button."
                                ]
                            }
                            visibleTitle
                        ]
                )
            ]
            state

    subscriptions : Modal.Model -> Sub Msg
    subscriptions state =
        Modal.subscriptions state

    view init
    --> text ""  -- a closed modal
```


## State and updates

@docs Model, init
@docs Msg, update, subscriptions

@docs open, close


## Views


### Modals

@docs info, warning


### View containers

@docs viewContent


### Focusable

@docs Focusable

@docs multipleFocusableElementView, onlyFocusableElementView


### Optional Config

@docs OptionalConfig
@docs invisibleTitle
@docs autofocusOnLastElement


## X icon

@docs closeButton

-}

import Accessibility.Modal.Copy as Modal
import Accessibility.Style
import Accessibility.Styled as Html exposing (..)
import Accessibility.Styled.Widget as Widget
import Color
import Color.Transparent as Transparent
import Css
import Css.Transitions
import Html.Styled.Attributes as Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Nri.Ui
import Nri.Ui.Colors.Extra
import Nri.Ui.Colors.V1 as Colors
import Nri.Ui.Fonts.V1 as Fonts
import Nri.Ui.SpriteSheet
import Nri.Ui.Svg.V1


{-| -}
type alias Model =
    Modal.Model


{-| expose intermediate type to make type signatures out of the library nicer
-}
type OptionalConfig msg
    = OptionalConfig (Config msg -> Config msg)
    | Attribute (Modal.Attribute msg)


configFuncs : List (OptionalConfig msg) -> List (Config msg -> Config msg)
configFuncs configs =
    List.filterMap
        (\optionalConfig ->
            case optionalConfig of
                OptionalConfig f ->
                    Just f

                Attribute _ ->
                    Nothing
        )
        configs


modalAttributes : List (OptionalConfig msg) -> List (Modal.Attribute msg)
modalAttributes configs =
    List.filterMap
        (\optionalConfig ->
            case optionalConfig of
                OptionalConfig _ ->
                    Nothing

                Attribute attrib ->
                    Just attrib
        )
        configs


{-| -}
autofocusOnLastElement : OptionalConfig msg
autofocusOnLastElement =
    Attribute Modal.autofocusOnLastElement


type alias Config msg =
    { visibleTitle : Bool
    , title : String
    , wrapMsg : Msg -> msg
    }


type alias RequiredConfig msg =
    { title : String, wrapMsg : Msg -> msg }


{-| This hides the modal's title
-}
invisibleTitle : OptionalConfig msg
invisibleTitle =
    OptionalConfig (\config -> { config | visibleTitle = False })


makeConfig : RequiredConfig msg -> List (OptionalConfig msg) -> Config msg
makeConfig { title, wrapMsg } optionalConfigs =
    optionalConfigs
        |> configFuncs
        |> List.foldl
            (\func accum -> func accum)
            (Config True title wrapMsg)


{-| -}
init : Model
init =
    Modal.init


{-| -}
type alias Msg =
    Modal.Msg


{-| Include the subscription if you want the modal to dismiss on `Esc`.
-}
subscriptions : Model -> Sub Msg
subscriptions =
    Modal.subscriptions


{-| -}
update : { dismissOnEscAndOverlayClick : Bool } -> Msg -> Model -> ( Model, Cmd Msg )
update config msg model =
    Modal.update config msg model


{-| -}
close : Msg
close =
    Modal.close


{-| Pass the id of the element that focus should return to when the modal closes.
-}
open : String -> Msg
open =
    Modal.open


{-| -}
info :
    RequiredConfig msg
    -> List (OptionalConfig msg)
    -> List (Focusable msg)
    -> Model
    -> Html msg
info config optionalConfigs focusables model =
    view Info config optionalConfigs focusables model


{-| -}
warning :
    RequiredConfig msg
    -> List (OptionalConfig msg)
    -> List (Focusable msg)
    -> Model
    -> Html msg
warning config optionalConfigs focusables model =
    view Warning config optionalConfigs focusables model


type Theme
    = Info
    | Warning


themeToOverlayColor : Theme -> Css.Color
themeToOverlayColor theme =
    case theme of
        Info ->
            Colors.navy

        Warning ->
            Colors.gray20


themeToTitleColor : Theme -> Css.Color
themeToTitleColor theme =
    case theme of
        Info ->
            Colors.navy

        Warning ->
            Colors.red


{-| -}
type Focusable msg
    = Focusable (Modal.Attribute msg)


{-| -}
multipleFocusableElementView :
    ({ firstFocusableElement : List (Html.Attribute msg)
     , lastFocusableElement : List (Html.Attribute msg)
     , autofocusElement : Html.Attribute msg
     }
     -> Html msg
    )
    -> Focusable msg
multipleFocusableElementView f =
    Focusable (Modal.multipleFocusableElementView (\attributes -> f attributes))


{-| -}
onlyFocusableElementView : (List (Html.Attribute msg) -> Html msg) -> Focusable msg
onlyFocusableElementView f =
    Focusable (Modal.onlyFocusableElementView (\attributes -> f attributes))


view :
    Theme
    -> RequiredConfig msg
    -> List (OptionalConfig msg)
    -> List (Focusable msg)
    -> Model
    -> Html msg
view theme requiredConfig optionalConfigs attributes model =
    let
        config =
            makeConfig requiredConfig optionalConfigs
    in
    Modal.view
        config.wrapMsg
        config.title
        ([ Modal.overlayColor (Nri.Ui.Colors.Extra.withAlpha 0.9 (themeToOverlayColor theme))
         , Modal.custom
            [ Css.width (Css.px 600)
            , Css.margin2 (Css.px 50) Css.auto
            , Css.borderRadius (Css.px 20)
            , Css.boxShadow5 Css.zero (Css.px 1) (Css.px 10) Css.zero (Css.rgba 0 0 0 0.35)
            , Css.backgroundColor Colors.white
            ]
         , if config.visibleTitle then
            Modal.titleStyles
                [ Fonts.baseFont
                , Css.fontWeight (Css.int 700)
                , Css.paddingTop (Css.px 40)
                , Css.paddingBottom (Css.px 20)
                , Css.margin Css.zero
                , Css.fontSize (Css.px 20)
                , Css.textAlign Css.center
                , Css.color (themeToTitleColor theme)
                ]

           else
            Modal.titleStyles
                [ -- https://snook.ca/archives/html_and_css/hiding-content-for-accessibility
                  Css.property "clip" "rect(1px, 1px, 1px, 1px)"
                , Css.position Css.absolute
                , Css.height (Css.px 1)
                , Css.width (Css.px 1)
                , Css.overflow Css.hidden
                , Css.margin (Css.px -1)
                , Css.padding Css.zero
                , Css.border Css.zero
                ]
         ]
            ++ modalAttributes optionalConfigs
            ++ List.map
                (\(Focusable f) -> f)
                attributes
        )
        model
        |> List.singleton
        |> div [ css [ Css.position Css.relative, Css.zIndex (Css.int 1) ] ]


{-| -}
viewContent : { content : List (Html msg), footer : List (Html msg) } -> Bool -> Html msg
viewContent { content, footer } visibleTitle =
    div []
        [ viewInnerContent content visibleTitle (not (List.isEmpty footer))
        , viewFooter footer
        ]


{-| -}
viewInnerContent : List (Html msg) -> Bool -> Bool -> Html msg
viewInnerContent children visibleTitle visibleFooter =
    let
        titleHeight =
            if visibleTitle then
                45

            else
                0

        footerHeight =
            if visibleFooter then
                180

            else
                0

        modalTitleStyles =
            if visibleTitle then
                []

            else
                [ Css.borderTopLeftRadius (Css.px 20)
                , Css.borderTopRightRadius (Css.px 20)
                , Css.overflowY Css.hidden
                ]

        modalFooterStyles =
            if visibleFooter then
                []

            else
                [ Css.borderBottomLeftRadius (Css.px 20)
                , Css.borderBottomRightRadius (Css.px 20)
                , Css.overflowY Css.hidden
                ]
    in
    div
        [ css (modalTitleStyles ++ modalFooterStyles)
        ]
        [ Nri.Ui.styled div
            "modal-content"
            [ Css.overflowY Css.auto
            , Css.minHeight (Css.px 150)
            , Css.width (Css.pct 100)
            , Css.boxSizing Css.borderBox
            , Css.paddingLeft (Css.px 40)
            , Css.paddingRight (Css.px 40)
            , if visibleTitle then
                Css.paddingTop Css.zero

              else
                Css.paddingTop (Css.px 40)
            , if visibleFooter then
                shadow (Transparent.customOpacity 0.15) (Css.px 16)

              else
                shadow (Transparent.customOpacity 0.4) (Css.px 30)
            ]
            [ css
                [ Css.maxHeight
                    (Css.calc (Css.vh 100)
                        Css.minus
                        (Css.px (footerHeight + titleHeight + 145))
                    )
                ]
            ]
            children
        ]


shadow : Transparent.Opacity -> Css.Px -> Css.Style
shadow opacity bottomShadowHeight =
    let
        to =
            Transparent.fromRGBA { red = 0, green = 0, blue = 0, alpha = opacity }
                |> Transparent.toRGBAString
    in
    Css.batch
        [ -- Shadows for indicating that the content is scrollable
          [ "/* TOP shadow */"
          , "top linear-gradient(to top, rgb(255, 255, 255), rgb(255, 255, 255)) local,"
          , "top linear-gradient(to top, rgba(255, 255, 255, 0), rgba(0, 0, 0, 0.15)) scroll,"
          , ""
          , "/* BOTTOM shadow */"
          , "bottom linear-gradient(to bottom, rgb(255, 255, 255), rgb(255, 255, 255)) local,"
          , "bottom linear-gradient(to bottom, rgba(255, 255, 255, 0), " ++ to ++ ") scroll"
          ]
            |> String.join "\n"
            |> Css.property "background"
        , Css.backgroundSize2 (Css.pct 100) bottomShadowHeight
        , Css.backgroundRepeat Css.noRepeat
        ]


{-| -}
viewFooter : List (Html msg) -> Html msg
viewFooter children =
    if List.isEmpty children then
        Html.text ""

    else
        Nri.Ui.styled div
            "modal-footer"
            [ Css.alignItems Css.center
            , Css.displayFlex
            , Css.flexDirection Css.column
            , Css.flexGrow (Css.int 2)
            , Css.flexWrap Css.noWrap
            , Css.margin4 (Css.px 20) Css.zero Css.zero Css.zero
            , Css.paddingBottom (Css.px 40)
            , Css.width (Css.pct 100)
            ]
            []
            children



--BUTTONS


{-| -}
closeButton : (Msg -> msg) -> List (Html.Attribute msg) -> Html msg
closeButton wrapMsg focusableElementAttrs =
    Nri.Ui.styled button
        "close-button-container"
        [ -- in the upper-right corner of the modal
          Css.position Css.absolute
        , Css.top Css.zero
        , Css.right Css.zero

        -- make the hitspace extend all the way to the corner
        , Css.width (Css.px 40)
        , Css.height (Css.px 40)
        , Css.padding4 (Css.px 20) (Css.px 20) (Css.px 2) Css.zero

        -- apply button styles
        , Css.borderWidth Css.zero
        , Css.backgroundColor Css.transparent
        , Css.cursor Css.pointer
        , Css.color Colors.azure
        , Css.hover [ Css.color Colors.azureDark ]
        , Css.Transitions.transition [ Css.Transitions.color 0.1 ]
        ]
        (Widget.label "Close modal"
            :: Attributes.map wrapMsg (onClick Modal.close)
            :: focusableElementAttrs
        )
        [ Nri.Ui.Svg.V1.toHtml Nri.Ui.SpriteSheet.xSvg
        ]
