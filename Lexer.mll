{
  open Parser
}

rule token = parse
  | [' ' '\t']+                                       { token lexbuf }
  | ['\n']                                            { token lexbuf }
  | ['0'-'9']+                                 as lxm {INT(int_of_string lxm) }
  | '+'                                               { PLUS }
  | '-'                                               { MINUS }
  | '*'                                               { MULTIPLY }
  | '/'                                               { DIVIDE }
  | '%'                                               { MOD }
  | '('                                               { LPAREN }
  | ')'                                               { RPAREN }
  | "if"                                              { IF }
  | "then"                                            { THEN }
  | "else"                                            { ELSE }
  | "while"                                           { WHILE }
  | '='                                               { ASSIGN }
  | '<'                                               { LE }
  | "<="                                              { LQ }
  | "||"                                              { OR }
  | "&&"                                              { AND }
  | '>'                                               { GE }
  | ">="                                              { GQ }
  | "=="                                              { EQ }
  | "!="                                              { NEQ }
  | "loop"                                            { LOOP }
  | "lst"                                             { LST }
  | "print"                                           { PRINT }
  | "printnewline"                                    { PRINTNL }
  | "readnextline"                                    { READNL }
  | "resetpipeat"                                     { RESETPIPEAT }
  | "pipelength"                                      { PIPELENGTH }
  | "pipecount"                                       { PIPECOUNT }
  | "loopstream"                                      { LOOPSTREAM }
  | '{'                                               { LBRACE }
  | '}'                                               { RBRACE }
  | ['a'-'z''A'-'Z']['a'-'z''A'-'Z''_''0'-'9']* as id { VAR( id ) }
  | '\"' [^'\"']* '\"'                         as txt { VAR(String.sub txt 1 (String.length txt - 2)) }
  | ';'                                               { ENDLINE }
  | eof                                               { EOF }
  | _ { token lexbuf }
