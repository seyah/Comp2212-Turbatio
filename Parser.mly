%{
    open Expressions;;
%}
%token <int> INT
%token <string> VAR
%token TRUE FALSE
%token PLUS MINUS MULTIPLY DIVIDE MOD ASSIGN
%token EQ NEQ LE LQ GE GQ
%token AND OR
%token LPAREN RPAREN
%token IF THEN ELSE WHILE LOOPSTREAM
%token LST LOOP
%token SET PRINT PRINTNL READNL RESETPIPEAT PIPELENGTH PIPECOUNT
%token LBRACE RBRACE
%token ENDLINE
%token EOF

%left PLUS MINUS
%left MULTIPLY DIV
%nonassoc UMINUS
%start top
%type <Expressions.expr list> top
%%
top:
  | exprtop top                 { $1 :: $2 }
  | exprtop EOF { [$1] }

conds:
  | exprtop { $1 }
  | exprtop conds { TurSeq($1, $2) }

exprtop:
  | expr ENDLINE { $1 }
  | WHILE LPAREN expr RPAREN LBRACE conds RBRACE { TurWhile($3, $6) }
  | LOOPSTREAM LBRACE conds RBRACE { TurLoopStream($3) }
  | IF LPAREN expr RPAREN LBRACE conds RBRACE { TurIf($3, $6) }
  | IF LPAREN expr RPAREN LBRACE conds RBRACE ELSE LBRACE conds RBRACE { TurIfElse($3, $6, $10) }

expr:
  | PRINTNL  { TurPrintNl }
  | READNL { TurReadNl }
  | PIPELENGTH { TurPipeLength }
  | PIPECOUNT { TurPipeCount }
  | RESETPIPEAT LPAREN expr RPAREN { TurResetPipe $3 }
  | VAR ASSIGN expr { TurAssign($1, $3) }
  | LST LPAREN expr RPAREN { TurLst $3 }
  | PRINT LPAREN expr RPAREN { TurPrint $3 }
  | INT { TurInt $1 }
  | MINUS expr %prec UMINUS       { TurNegate $2 }
  | VAR { TurVar $1 }
  | TRUE { TurBoolean true }
  | FALSE { TurBoolean false }
  | expr PLUS expr { TurPlus($1, $3) }
  | expr MINUS expr { TurMinus($1, $3) }
  | expr MULTIPLY expr { TurMultiply($1, $3) }
  | expr DIVIDE expr { TurDivide($1, $3) }
  | expr MOD expr { TurMod($1, $3) }
  | expr EQ expr { TurEq($1, $3) }
  | expr NEQ expr { TurNeq($1, $3) }
  | expr LE expr { TurLe($1, $3) }
  | expr LQ expr { TurLq($1, $3) }
  | expr GE expr { TurGe($1, $3) }
  | expr GQ expr { TurGq($1, $3) }
  | expr AND expr { TurAnd($1, $3) }
  | expr OR expr { TurOr($1, $3) }
  | LPAREN expr RPAREN { $2 }
;