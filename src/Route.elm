module Route exposing (render)

import Utils.Template as Utils


render : List String -> String
render names =
    let
        routeCustomType =
            names
                |> Utils.customType
                |> Utils.indent 1

        routeParsers =
            names
                |> List.map toParser
                |> Utils.list
                |> Utils.indent 2
    in
    """
module Route exposing (routes)

import Url.Parser as Parser exposing (Parser)


type Route
{{routeCustomType}}


routes : Parser (Route -> a) a
routes =
    Parser.oneOf
{{routeParsers}}
  """
        |> String.replace "{{routeCustomType}}" routeCustomType
        |> String.replace "{{routeParsers}}" routeParsers
        |> String.trim


toParser : String -> String
toParser name =
    "Parser.map " ++ name ++ " (Parser.s \"" ++ Utils.sluggify name ++ "\")"
