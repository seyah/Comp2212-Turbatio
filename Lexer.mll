{
  open Parser
  exception Eof
  exception Not_Found
}

rule token = parse
  | [' ' '\t'] { token lexbuf }
  | ['\n'] { EOL }
  | ['0'-'9']+ as lxm {INT(int_of_string lxm) }
  | '+' { PLUS }
  | '-' { MINUS }
  | '*' { MULTIPLY }
  | '/' { DIVIDE }
  | '^' { POWER }
  | '%' { MOD }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | "if" { IF }
  | "then" { THEN }
  | "else" { ELSE }
  | "while" { WHILE }
  | '<'       { LE }
  | "<="      { LQ }
  | "||"      { OR }
  | "&&"      { AND }
  | '>'       { GE }
  | ">="      { GQ }
  | "=="      { EQ }
  | "!="      { NEQ }
  | '{' { LBRACE }
  | '}' { RBRACE }
  | "enter" { ENTER }
  | "exit" { EXIT }
  | ['a'-'z''A'-'Z']['a'-'z''A'-'Z''_''0'-'9']* as id { VAR( id ) }
  | eof { raise Eof }
