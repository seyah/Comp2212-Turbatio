{
  open Parser
  exception Eof
  exception Not_Found
}

rule token = parse
    [' ' '\t'] { main lexbuf }
  | ['\n'] { EOL }
  | ['0'-'9']+ as lxm {INT(int_of_string lxm) }
  | '+' { PLUS }
  | '-' { MINUS }
  | '*' { TIMES }
  | '/' { DIV }
  | '^' { POWER }
  | '%' { MOD }
  | ':' { COLON }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | "if" { IF }
  | "then" { THEN }
  | "else" { ELSE }
  | "enter" { ENTER }
  | "exit" { EXIT }
  | "process" { PROCESS }
  | "while" { WHILE }
  | '<'       { LE }
  | "<="      { LQ }
  | "||"      { OR }
  | "&&"      { AND }
  | '>'       { GE }
  | ">="      { GQ }
  | "=="      { EQ }
  | "!="      { NEQU }
  | '{' { LBRACE }
  | '}' { RBRACE }
  | ['a'-'z''A'-'Z''_']['a'-'z''A'-'Z''_''0'-'9']* as ident { STRING( ident ) }
  | eof { raise Eof }
