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

open Parsing;;
let _ = parse_error;;
# 1 "Parser.mly"

    open Expressions;;
# 40 "Parser.ml"
let yytransl_const = [|
  260 (* TRUE *);
  261 (* FALSE *);
  262 (* PLUS *);
  263 (* MINUS *);
  264 (* MULTIPLY *);
  265 (* DIVIDE *);
  266 (* POWER *);
  267 (* MOD *);
  268 (* EQ *);
  269 (* NEQ *);
  270 (* LE *);
  271 (* LQ *);
  272 (* GE *);
  273 (* GQ *);
  274 (* AND *);
  275 (* OR *);
  276 (* LPAREN *);
  277 (* RPAREN *);
  278 (* EOL *);
  279 (* IF *);
  280 (* THEN *);
  281 (* ELSE *);
  282 (* WHILE *);
  283 (* LBRACE *);
  284 (* RBRACE *);
  285 (* ENTER *);
  286 (* EXIT *);
  287 (* PROCESS *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* ID *);
  259 (* VAR *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\000\000"

let yylen = "\002\000\
\005\000\001\000\001\000\001\000\001\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\008\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\022\000\000\000\002\000\003\000\004\000\
\005\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\006\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\001\000\000\000\000\000\
\000\000\000\000\000\000"

let yydgoto = "\002\000\
\004\000\012\000"

let yysindex = "\001\000\
\228\254\000\000\232\254\000\000\032\255\000\000\000\000\000\000\
\000\000\032\255\014\255\013\255\090\255\032\255\032\255\032\255\
\032\255\032\255\032\255\032\255\032\255\032\255\032\255\032\255\
\032\255\032\255\032\255\032\255\009\255\000\000\106\255\134\255\
\134\255\145\255\122\255\122\255\122\255\122\255\122\255\122\255\
\122\255\122\255\122\255\122\255\122\255\000\000\021\255\032\255\
\070\255\032\255\122\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\041\255\
\047\255\036\255\035\255\046\255\144\255\146\255\152\255\154\255\
\160\255\162\255\168\255\170\255\176\255\000\000\000\000\000\000\
\000\000\000\000\178\255"

let yygindex = "\000\000\
\000\000\246\255"

let yytablesize = 206
let yytable = "\013\000\
\003\000\001\000\005\000\031\000\032\000\033\000\034\000\035\000\
\036\000\037\000\038\000\039\000\040\000\041\000\042\000\043\000\
\044\000\045\000\015\000\016\000\017\000\018\000\019\000\020\000\
\021\000\022\000\023\000\024\000\025\000\026\000\027\000\028\000\
\006\000\014\000\007\000\008\000\009\000\049\000\046\000\051\000\
\029\000\009\000\009\000\009\000\048\000\000\000\007\000\007\000\
\000\000\000\000\000\000\010\000\008\000\008\000\011\000\010\000\
\009\000\000\000\000\000\010\000\009\000\007\000\010\000\009\000\
\000\000\007\000\011\000\008\000\007\000\000\000\011\000\008\000\
\000\000\011\000\008\000\015\000\016\000\017\000\018\000\019\000\
\020\000\021\000\022\000\023\000\024\000\025\000\026\000\027\000\
\028\000\000\000\000\000\000\000\000\000\000\000\050\000\015\000\
\016\000\017\000\018\000\019\000\020\000\021\000\022\000\023\000\
\024\000\025\000\026\000\027\000\028\000\000\000\030\000\015\000\
\016\000\017\000\018\000\019\000\020\000\021\000\022\000\023\000\
\024\000\025\000\026\000\027\000\028\000\000\000\047\000\015\000\
\016\000\017\000\018\000\019\000\020\000\021\000\022\000\023\000\
\024\000\025\000\026\000\027\000\028\000\017\000\018\000\019\000\
\020\000\021\000\022\000\023\000\024\000\025\000\026\000\027\000\
\028\000\018\000\019\000\020\000\021\000\022\000\023\000\024\000\
\025\000\026\000\027\000\028\000\012\000\000\000\013\000\000\000\
\012\000\000\000\013\000\012\000\014\000\013\000\015\000\000\000\
\014\000\000\000\015\000\014\000\016\000\015\000\017\000\000\000\
\016\000\000\000\017\000\016\000\018\000\017\000\019\000\000\000\
\018\000\000\000\019\000\018\000\020\000\019\000\021\000\000\000\
\020\000\000\000\021\000\020\000\000\000\021\000"

let yycheck = "\010\000\
\029\001\001\000\027\001\014\000\015\000\016\000\017\000\018\000\
\019\000\020\000\021\000\022\000\023\000\024\000\025\000\026\000\
\027\000\028\000\006\001\007\001\008\001\009\001\010\001\011\001\
\012\001\013\001\014\001\015\001\016\001\017\001\018\001\019\001\
\001\001\020\001\003\001\004\001\005\001\048\000\030\001\050\000\
\028\001\006\001\007\001\008\001\024\001\255\255\006\001\007\001\
\255\255\255\255\255\255\020\001\006\001\007\001\023\001\021\001\
\021\001\255\255\255\255\025\001\025\001\021\001\028\001\028\001\
\255\255\025\001\021\001\021\001\028\001\255\255\025\001\025\001\
\255\255\028\001\028\001\006\001\007\001\008\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\017\001\018\001\
\019\001\255\255\255\255\255\255\255\255\255\255\025\001\006\001\
\007\001\008\001\009\001\010\001\011\001\012\001\013\001\014\001\
\015\001\016\001\017\001\018\001\019\001\255\255\021\001\006\001\
\007\001\008\001\009\001\010\001\011\001\012\001\013\001\014\001\
\015\001\016\001\017\001\018\001\019\001\255\255\021\001\006\001\
\007\001\008\001\009\001\010\001\011\001\012\001\013\001\014\001\
\015\001\016\001\017\001\018\001\019\001\008\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\017\001\018\001\
\019\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\019\001\021\001\255\255\021\001\255\255\
\025\001\255\255\025\001\028\001\021\001\028\001\021\001\255\255\
\025\001\255\255\025\001\028\001\021\001\028\001\021\001\255\255\
\025\001\255\255\025\001\028\001\021\001\028\001\021\001\255\255\
\025\001\255\255\025\001\028\001\021\001\028\001\021\001\255\255\
\025\001\255\255\025\001\028\001\255\255\028\001"

let yynames_const = "\
  TRUE\000\
  FALSE\000\
  PLUS\000\
  MINUS\000\
  MULTIPLY\000\
  DIVIDE\000\
  POWER\000\
  MOD\000\
  EQ\000\
  NEQ\000\
  LE\000\
  LQ\000\
  GE\000\
  GQ\000\
  AND\000\
  OR\000\
  LPAREN\000\
  RPAREN\000\
  EOL\000\
  IF\000\
  THEN\000\
  ELSE\000\
  WHILE\000\
  LBRACE\000\
  RBRACE\000\
  ENTER\000\
  EXIT\000\
  PROCESS\000\
  "

let yynames_block = "\
  INT\000\
  ID\000\
  VAR\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    Obj.repr(
# 24 "Parser.mly"
                                  ( _3 )
# 222 "Parser.ml"
               : Expressions.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 28 "Parser.mly"
        ( Int _1 )
# 229 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 29 "Parser.mly"
        ( Var _1 )
# 236 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 30 "Parser.mly"
         ( Boolean true )
# 242 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 31 "Parser.mly"
          ( Boolean false )
# 248 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 32 "Parser.mly"
                       ( _2 )
# 255 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 33 "Parser.mly"
                   ( Plus(_1, _3) )
# 263 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 34 "Parser.mly"
                    ( Minus(_1, _3) )
# 271 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 35 "Parser.mly"
                       ( Multiply(_1, _3) )
# 279 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 36 "Parser.mly"
                     ( Divide(_1, _3) )
# 287 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 37 "Parser.mly"
                    ( Power(_1, _3) )
# 295 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 38 "Parser.mly"
                  ( Mod(_1, _3) )
# 303 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 39 "Parser.mly"
                 ( Eq(_1, _3) )
# 311 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 40 "Parser.mly"
                  ( Neq(_1, _3) )
# 319 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 41 "Parser.mly"
                 ( Le(_1, _3) )
# 327 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 42 "Parser.mly"
                 ( Lq(_1, _3) )
# 335 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 43 "Parser.mly"
                 ( Ge(_1, _3) )
# 343 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 44 "Parser.mly"
                 ( Gq(_1, _3) )
# 351 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 45 "Parser.mly"
                  ( And(_1, _3) )
# 359 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 46 "Parser.mly"
                 ( Or(_1, _3) )
# 367 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 5 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 47 "Parser.mly"
                                              ( If(_3, _6, _8) )
# 376 "Parser.ml"
               : 'expr))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Expressions.expr)
