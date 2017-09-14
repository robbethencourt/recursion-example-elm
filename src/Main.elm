module Main exposing (..)

import Html exposing (Html, text, div, p, button, h5, input)
import Html.Attributes exposing (class, style, type_)
import Html.Events exposing (onClick, onInput)


---- MODEL ----


type alias Model =
    { myList : List Int
    , reduced : Int
    , inputNumber : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { myList = List.range 1 3
      , reduced = 0
      , inputNumber = 0
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = ReduceIt
    | ClearIt
    | UpdateInput String
    | NewList


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReduceIt ->
            ( { model
                | reduced = reduceEx 0 model.myList
              }
            , Cmd.none
            )

        ClearIt ->
            ( { model
                | reduced = 0
              }
            , Cmd.none
            )

        UpdateInput inputNumber ->
            ( { model
                | inputNumber = Result.withDefault 0 (String.toInt inputNumber)
              }
            , Cmd.none
            )

        NewList ->
            ( { model
                | myList = List.range 0 model.inputNumber
              }
            , Cmd.none
            )


reduceEx : Int -> List Int -> Int
reduceEx val list =
    case list of
        [] ->
            val

        h :: rest ->
            reduceEx (h + val) rest



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ style [ ( "margin-left", "25%" ) ] ]
        [ div []
            [ p [] [ text (toString model.myList) ]
            , button
                [ onClick ReduceIt ]
                [ text "Reduce It" ]
            , p [] [ text (toString model.reduced) ]
            , button
                [ class "outline"
                , onClick ClearIt
                ]
                [ text "Clear It" ]
            , div []
                [ input
                    [ type_ "number"
                    , onInput UpdateInput
                    , style [ ( "width", "50%" ) ]
                    ]
                    []
                ]
            , div []
                [ button
                    [ onClick NewList ]
                    []
                    [ text "Update List" ]
                ]
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
