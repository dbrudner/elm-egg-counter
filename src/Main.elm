module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Attribute, Html, button, div, h1, h2, input, text)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (onClick, onInput)
import String



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type Gender
    = Male
    | Female


type alias Model =
    { age : String
    , eggs : String
    , gender : Gender
    }


init : Model
init =
    { age = "25"
    , eggs = "5"
    , gender = Male
    }



-- UPDATE


type Msg
    = UpdateAge String
    | UpdateEggs String
    | SelectMale
    | SelectFemale


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateAge input ->
            { model | age = input }

        UpdateEggs input ->
            { model | eggs = input }

        SelectMale ->
            { model | gender = Male }

        SelectFemale ->
            { model | gender = Female }



-- VIEW


calculateAverageEggs : Model -> Float -> String
calculateAverageEggs model avgAge =
    String.fromFloat ((avgAge - String.toFloat model.age) * String.toFloat model.eggs)


createOutput : Model -> String
createOutput model =
    if model.gender == Female then
        "You will eat " ++ calculateAverageEggs model 81.2 ++ " eggs from now until you die"

    else
        "Sup"


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Age", value model.age, onInput UpdateAge ] []
        , input [ placeholder "Eggs", value model.age, onInput UpdateEggs ] []
        , button [ classList [ ( "active", model.gender == Male ) ], onClick SelectMale ] [ text "male" ]
        , button [ classList [ ( "active", model.gender == Female ) ], onClick SelectFemale ] [ text "female" ]
        , h2 [] [ text "Input" ]
        , div [] [ text "Hey" ]
        , h2 [] [ text "Output" ]
        , div [] [ text (createOutput model) ]
        ]
