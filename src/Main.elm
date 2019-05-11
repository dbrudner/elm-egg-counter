module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Attribute, Html, button, div, h1, h2, h3, input, p, text)
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
    { age = ""
    , eggs = ""
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


convertToFloat : String -> Float
convertToFloat float =
    case String.toFloat float of
        Just num ->
            num

        Nothing ->
            0


convertToString : Int -> String
convertToString int =
    String.fromInt int


calculateEggs : Model -> String
calculateEggs model =
    if model.gender == Female then
        convertToString (round ((81.2 - convertToFloat model.age) * convertToFloat model.eggs * 365))

    else
        convertToString (round ((76.4 - convertToFloat model.age) * convertToFloat model.eggs * 365))


createOutput : Model -> String
createOutput model =
    "You will eat " ++ calculateEggs model ++ " eggs from now until you die"


genderToString : Gender -> String
genderToString gender =
    if gender == Female then
        "Female"

    else
        "Male"


createInput : String -> String -> Html Msg
createInput label value =
    div []
        [ h3 [] [ text label ]
        , p [] [ text value ]
        ]


createInputs : Model -> Html Msg
createInputs model =
    div [ classList [ ( "input", True ) ] ]
        [ createInput "Eggs per day" model.eggs
        , createInput "Age" model.age
        , createInput "Gender" (genderToString model.gender)
        ]


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Egg Counter" ]
        , input [ placeholder "Age in years", value model.age, onInput UpdateAge ] []
        , input [ placeholder "Daily egg intake", value model.eggs, onInput UpdateEggs ] []
        , button [ classList [ ( "active", model.gender == Male ) ], onClick SelectMale ] [ text "male" ]
        , button [ classList [ ( "active", model.gender == Female ) ], onClick SelectFemale ] [ text "female" ]
        , h2 [] [ text "Input" ]
        , createInputs model
        , h2 [] [ text "Output" ]
        , div [] [ text (createOutput model) ]
        ]
