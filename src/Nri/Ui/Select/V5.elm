module Nri.Ui.Select.V5 exposing (Config, view)

{-| Build a select input.

@docs Config, view

-}

import Css
import Dict
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Json.Decode exposing (Decoder, andThen, succeed)
import Nri.Ui
import Nri.Ui.Colors.V1
import Nri.Ui.Util


{-| Configure a Select
-}
type alias Config a =
    { choices : List { label : String, value : a }
    , current : a
    , id : Maybe String
    , valueToString : a -> String
    }


{-| TODO: Consider moving this to Nri.Ui.Util once the non-0.19-approved `toString` is removed
-}
niceId : String -> String -> String
niceId prefix x =
    prefix ++ "-" ++ Nri.Ui.Util.dashify (Nri.Ui.Util.removePunctuation x)


{-| A select dropdown
-}
view : Config a -> Html a
view config =
    let
        valueLookup =
            -- TODO: probably worth using Lazy here, since choices won't change often
            config.choices
                |> List.map (\x -> ( niceId "nri-select" (config.valueToString x.value), x.value ))
                |> Dict.fromList

        decodeValue string =
            Dict.get string valueLookup
                |> Maybe.map Json.Decode.succeed
                |> Maybe.withDefault (Json.Decode.fail ("Nri.Select: could not decode the value: " ++ string ++ "\nexpected one of: " ++ String.join ", " (Dict.keys valueLookup)))

        onSelectHandler =
            on "change" (targetValue |> andThen decodeValue)

        viewChoice choice =
            Html.option
                [ Attributes.id (niceId "nri-select" (config.valueToString choice.value))
                , Attributes.value (niceId "nri-select" (config.valueToString choice.value))
                , Attributes.selected (choice.value == config.current)
                ]
                [ Html.text choice.label ]

        extraAttrs =
            config.id
                |> Maybe.map (\id -> [ Attributes.id id ])
                |> Maybe.withDefault []
    in
    config.choices
        |> List.map viewChoice
        |> Nri.Ui.styled Html.select
            "nri-select-menu"
            [ Css.backgroundColor Nri.Ui.Colors.V1.white
            , Css.border3 (Css.px 1) Css.solid Nri.Ui.Colors.V1.gray75
            , Css.borderRadius (Css.px 8)
            , Css.color Nri.Ui.Colors.V1.gray20
            , Css.cursor Css.pointer
            , Css.fontSize (Css.px 15)
            , Css.height (Css.px 45)
            , Css.width (Css.pct 100)
            ]
            ([ onSelectHandler ] ++ extraAttrs)
