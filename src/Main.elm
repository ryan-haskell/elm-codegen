module Main exposing (main)

import Ports
import Route



-- PROGRAM


type alias Flags =
    List String


main : Program Flags Model Msg
main =
    Platform.worker
        { init = init
        , update = update
        , subscriptions = always Sub.none
        }



-- INIT


type alias Model =
    ()


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( (), Ports.log (Route.render flags) )



-- UPDATE


type alias Msg =
    Never


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )
