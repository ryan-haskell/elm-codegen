module Utils.Template exposing
    ( customType
    , indent
    , list
    , sluggify
    )


customType : List String -> String
customType items =
    case items of
        [] ->
            ""

        _ ->
            items
                |> List.indexedMap
                    (\i item ->
                        if i == 0 then
                            "= " ++ item

                        else
                            "| " ++ item
                    )
                |> String.join "\n"


list : List String -> String
list items =
    case items of
        [] ->
            "[]"

        _ ->
            (items
                |> List.indexedMap
                    (\i item ->
                        if i == 0 then
                            "[ " ++ item

                        else
                            ", " ++ item
                    )
                |> String.join "\n"
            )
                ++ "\n]"


indent : Int -> String -> String
indent num str =
    str
        |> String.lines
        |> List.map (String.append (List.repeat num "    " |> String.concat))
        |> String.join "\n"


sluggify : String -> String
sluggify str =
    str
        |> String.toList
        |> List.map
            (\char ->
                if Char.isUpper char then
                    " " ++ String.fromChar char

                else
                    String.fromChar char
            )
        |> String.join ""
        |> String.trim
        |> String.replace " " "-"
        |> String.toLower
