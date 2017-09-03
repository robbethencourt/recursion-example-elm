module Main exposing (..)

import Html exposing (Html, text, div, p, button, h5, input)
import Html.Attributes exposing (class, style, type_)
import Html.Events exposing (onClick)


---- MODEL ----


type alias Model =
    { myList : List Int
    , reduced : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { myList = List.range 1 7
      , reduced = 0
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = ReduceIt
    | ClearIt


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
                    , style [ ( "width", "50%" ) ]
                    ]
                    []
                ]
            , div []
                [ button
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
