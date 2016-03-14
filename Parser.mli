type token =
  | INT of (int)
  | ID of (string)
  | VAR of (string)
  | TRUE
  | FALSE
  | PLUS
  | MINUS
  | MULTIPLY
  | DIVIDE
  | POWER
  | MOD
  | EQ
  | NEQ
  | LE
  | LQ
  | GE
  | GQ
  | AND
  | OR
  | LPAREN
  | RPAREN
  | EOL
  | IF
  | THEN
  | ELSE
  | WHILE
  | LBRACE
  | RBRACE
  | ENTER
  | EXIT
  | PROCESS

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Expressions.expr
