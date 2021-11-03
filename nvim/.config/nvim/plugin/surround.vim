" tutorial
"
" cs<surroundChar1><surroundChar2> -> change surround from 1 to 2
" example: "hello world" -> cs"<q> -> <q>hello world</q>
"
" cst<surrounfChar> -> change surrounding tag to given char
" <q>helo world</q> -> cst" -> "hello world"
"
" ds<surround> -> delete surrounding things
""hello world" -> ds" -> hello world
"
" ysiw<char> -> surround word with char
" hello world -> ysiw] -> [hello] world!
" PS: iw is text object, it can be 2w for example
"
"[hello] world! -> cs[{ -> { hello } world! (use } for no space)
"
"surround entire line with parenthesis with yss)
"
"
" [ opa mundo ]

