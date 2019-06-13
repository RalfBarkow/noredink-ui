module Nri.Ui.SpriteSheet exposing
    ( arrowLeft
    , bulb
    , checkmark
    , exclamationMark
    , xSvg
    )

{-|

@docs arrowLeft
@docs bulb
@docs checkmark
@docs exclamationMark
@docs xSvg

-}

import Html.Styled exposing (..)
import Nri.Ui.Svg.V1 as NriSvg
import Svg exposing (..)
import Svg.Attributes exposing (..)


{-| -}
exclamationMark : NriSvg.Svg
exclamationMark =
    Svg.svg
        [ viewBox "0 0 4 12", width "100%", height "100%" ]
        [ Svg.path
            [ d "M3.234 10.575a1.363 1.363 0 1 1-2.726 0 1.363 1.363 0 0 1 2.726 0zm.648-8.398a1.978 1.978 0 0 1-.007.047l-.834 5.294c-.079.53-.542.926-1.085.926h-.013a1.096 1.096 0 0 1-1.085-.926L.024 2.224A1.93 1.93 0 0 1 1.93 0h.04a1.94 1.94 0 0 1 1.912 1.663v.514z"
            , fill "currentcolor"
            , fillRule "evenodd"
            ]
            []
        ]
        |> fromUnstyled
        |> NriSvg.fromHtml


{-| -}
checkmark : NriSvg.Svg
checkmark =
    Svg.svg
        [ id "Layer_1"
        , x "0px"
        , y "0px"
        , viewBox "0 0 21.7 17.1"
        , Svg.Attributes.style "enable-background:new 0 0 21.7 17.1;"
        , width "100%"
        , height "100%"
        ]
        [ Svg.path
            [ id "check-white"
            , fill "currentcolor"
            , d "M7.6,17.1c-0.5,0-1-0.2-1.4-0.6l-5.6-5.4c-0.8-0.8-0.8-2-0.1-2.8c0.8-0.8,2-0.8,2.8-0.1l4.1,4 L18.2,0.7c0.8-0.8,2-0.9,2.8-0.1s0.9,2,0.1,2.8l-12,13C8.7,16.9,8.2,17.1,7.6,17.1C7.7,17.1,7.6,17.1,7.6,17.1"
            ]
            []
        ]
        |> fromUnstyled
        |> NriSvg.fromHtml


{-| -}
bulb : NriSvg.Svg
bulb =
    svg
        [ version "1.1"
        , id "Layer_1"
        , x "0px"
        , y "0px"
        , viewBox "0 0 23 25"
        , Svg.Attributes.style "enable-background:new 0 0 23 25;"
        , width "100%"
        , height "100%"
        ]
        [ Svg.style [] [ Svg.text ".blub-st0{fill:#FEC709;} " ]
        , g [ id "feedback" ]
            [ g [ id "dot-tip", transform "translate(-261.000000, -371.000000)" ]
                [ g
                    [ id "alerts_x2F_tip"
                    , transform "translate(259.886945, 371.000000)"
                    ]
                    [ g [ id "icon_x2F_bulb-yellow", transform "translate(0.859754, 0.051946)" ]
                        [ g [ id "Group", transform "translate(0.461538, 0.000000)" ]
                            [ Svg.path
                                [ id "Fill-1"
                                , class "blub-st0"
                                , d "M21.6,12.5H19c-0.3,0-0.6,0.3-0.6,0.6s0.3,0.6,0.6,0.6h2.6c0.3,0,0.6-0.3,0.6-0.6 S21.9,12.5,21.6,12.5z"
                                ]
                                []
                            , Svg.path
                                [ id "Fill-2"
                                , class "blub-st0"
                                , d "M18.1,9.3c0.1,0,0.2,0,0.3-0.1l2.3-1.4C20.9,7.7,21,7.3,20.8,7c-0.2-0.3-0.5-0.4-0.8-0.2 l-2.3,1.4c-0.2,0.1-0.3,0.4-0.3,0.7C17.6,9.1,17.8,9.3,18.1,9.3L18.1,9.3z"
                                ]
                                []
                            , Svg.path
                                [ id "Fill-3"
                                , class "blub-st0"
                                , d "M17.1,2c-0.3-0.2-0.6-0.1-0.8,0.2l-1.5,2.2h0c-0.1,0.1-0.1,0.3-0.1,0.5c0,0.2,0.1,0.3,0.2,0.4 c0.1,0.1,0.3,0.1,0.4,0.1c0.2,0,0.3-0.1,0.4-0.3l1.5-2.2C17.4,2.6,17.4,2.2,17.1,2L17.1,2z"
                                ]
                                []
                            , Svg.path
                                [ id "Fill-4"
                                , class "blub-st0"
                                , d "M6.7,5.4c0.2,0,0.4-0.1,0.5-0.3c0.1-0.2,0.1-0.4,0-0.6L5.7,2.2v0C5.6,2.1,5.4,2,5.3,1.9 C5.1,1.9,5,1.9,4.9,2C4.7,2.1,4.6,2.3,4.6,2.4c0,0.2,0,0.3,0.1,0.4l1.5,2.2C6.3,5.3,6.5,5.4,6.7,5.4L6.7,5.4z"
                                ]
                                []
                            , Svg.path
                                [ id "Fill-5"
                                , class "blub-st0"
                                , d "M4,8.2L1.7,6.8C1.5,6.7,1.1,6.8,1,7C0.8,7.3,0.9,7.6,1.2,7.8l2.3,1.4c0.1,0.1,0.3,0.1,0.4,0.1 C4,9.2,4.1,9.1,4.2,9c0.1-0.1,0.1-0.3,0.1-0.5C4.2,8.4,4.1,8.2,4,8.2L4,8.2z"
                                ]
                                []
                            , Svg.path
                                [ id "Fill-6"
                                , class "blub-st0"
                                , d "M20.6,17.8l-2.2-1.4c-0.3-0.2-0.6-0.1-0.8,0.2c-0.2,0.3-0.1,0.6,0.2,0.8l2.3,1.4 c0.3,0.1,0.6,0,0.7-0.2C21,18.3,20.9,18,20.6,17.8L20.6,17.8z"
                                ]
                                []
                            , Svg.path
                                [ id "Fill-7"
                                , class "blub-st0"
                                , d "M3.5,16.4l-2.3,1.4h0C1.1,17.8,1,18,0.9,18.1c0,0.2,0,0.3,0.1,0.5c0.1,0.1,0.2,0.2,0.4,0.3 c0.1,0,0.3,0,0.4-0.1L4,17.4c0.3-0.2,0.3-0.5,0.2-0.8C4.1,16.4,3.7,16.3,3.5,16.4L3.5,16.4z"
                                ]
                                []
                            , Svg.path
                                [ id "Fill-8"
                                , class "blub-st0"
                                , d "M3.7,13.1c0-0.3-0.3-0.6-0.6-0.6H0.6c-0.3,0-0.6,0.3-0.6,0.6s0.3,0.6,0.6,0.6h2.6 c0.1,0,0.3-0.1,0.4-0.2C3.7,13.4,3.7,13.2,3.7,13.1L3.7,13.1z"
                                ]
                                []
                            , Svg.path
                                [ id "Fill-9"
                                , class "blub-st0"
                                , d "M10.7,3.9c0.3,0,0.6-0.3,0.6-0.6V0.6C11.3,0.3,11,0,10.7,0c-0.3,0-0.6,0.3-0.6,0.6v2.7 c0,0.2,0.1,0.3,0.2,0.4S10.6,3.9,10.7,3.9L10.7,3.9z"
                                ]
                                []
                            , Svg.path
                                [ id "Fill-10"
                                , class "blub-st0"
                                , d "M13.4,20.2H8.9c-0.3,0-0.6,0.3-0.6,0.6c0,0.3,0.3,0.6,0.6,0.6h4.5c0.3,0,0.6-0.3,0.6-0.6 C14,20.5,13.7,20.2,13.4,20.2z"
                                ]
                                []
                            , Svg.path
                                [ id "Fill-11"
                                , class "blub-st0"
                                , d "M10,23.5v0.3c0,0.4,0.3,0.7,0.6,0.7h0.9c0.4,0,0.6-0.3,0.6-0.7v-0.3c0.7,0,1.3-0.7,1.3-1.4 H8.8C8.9,22.8,9.4,23.4,10,23.5L10,23.5z"
                                ]
                                []
                            , Svg.path
                                [ id "Fill-12"
                                , class "blub-st0"
                                , d "M11.2,6.7c-3.1,0-5.6,2.7-5.6,6v0c0,0.8,0.1,1.5,0.4,2.3c0,0.1,0.1,0.2,0.1,0.3h0 c0.2,0.6,0.6,1.1,1,1.6l1.4,2.3h5.4l1.4-2.3c0.4-0.5,0.7-1,1-1.6c0-0.1,0.1-0.2,0.1-0.3h0c0.3-0.7,0.4-1.5,0.4-2.3 C16.8,9.4,14.3,6.7,11.2,6.7L11.2,6.7z M10.9,9c-0.6,0-1.2,0.2-1.7,0.5c-1.1,0.7-1.6,1.9-1.7,3.5v0c0,0.3-0.3,0.6-0.6,0.6 c-0.1,0-0.3-0.1-0.4-0.2c-0.1-0.1-0.2-0.3-0.2-0.4c0-2.7,1.3-4,2.3-4.6c0.7-0.4,1.4-0.6,2.2-0.7c0.3,0,0.6,0.3,0.6,0.6 C11.5,8.7,11.2,9,10.9,9L10.9,9z"
                                ]
                                []
                            ]
                        ]
                    ]
                ]
            ]
        ]
        |> fromUnstyled
        |> NriSvg.fromHtml


{-| -}
arrowLeft : NriSvg.Svg
arrowLeft =
    svg
        [ viewBox "0 0 25 25"
        , width "100%"
        , height "100%"
        , fill "currentcolor"
        ]
        [ Svg.path
            [ fillRule "evenodd"
            , d "M19.2677026,20.7322696 C20.2443584,21.7070736 20.2443584,23.2915005 19.2677026,24.2677859 C18.7788191,24.7555583 18.139567,25 17.4999444,25 C16.8603219,25 16.2210698,24.7555583 15.7321863,24.2677859 L5.73229742,14.267897 C4.7556416,13.293093 4.7556416,11.7086662 5.73229742,10.7323808 L15.7321863,0.732491861 C16.7084718,-0.244163954 18.2914171,-0.244163954 19.2677026,0.732491861 C20.2443584,1.70729584 20.2443584,3.29172268 19.2677026,4.26800813 L11.0359422,12.5001389 L19.2677026,20.7322696 Z"
            ]
            []
        ]
        |> fromUnstyled
        |> NriSvg.fromHtml


xSvg : NriSvg.Svg
xSvg =
    svg
        [ viewBox "0 0 25 25"
        , width "100%"
        , height "100%"
        , fill "currentcolor"
        ]
        [ Svg.path
            [ d "M1.067 6.015c-1.423-1.422-1.423-3.526 0-4.948 1.422-1.423 3.526-1.423 4.948 0l6.371 6.37 6.371-6.37c1.422-1.423 3.783-1.423 5.176 0 1.423 1.422 1.423 3.782 0 5.176l-6.37 6.37 6.37 6.372c1.423 1.422 1.423 3.526 0 4.948-1.422 1.423-3.526 1.423-4.948 0l-6.371-6.37-6.371 6.37c-1.422 1.423-3.783 1.423-5.176 0-1.423-1.422-1.423-3.782 0-5.176l6.37-6.143-6.37-6.599z"
            ]
            []
        ]
        |> fromUnstyled
        |> NriSvg.fromHtml
