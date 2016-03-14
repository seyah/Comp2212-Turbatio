%{
    open Expressions;;
%}
%token <int> INT
%token <string> ID
%token <string> VAR
%token TRUE FALSE
%token PLUS MINUS MULTIPLY DIVIDE POWER MOD
%token EQ NEQ LE LQ GE GQ
%token AND OR
%token LPAREN RPAREN
%token EOL
%token IF THEN ELSE WHILE
%token LBRACE RBRACE
%token ENTER EXIT PROCESS

%left PLUS MINUS        /* lowest precedence */
%left MULTIPLY DIV         /* medium precedence */
%nonassoc UMINUS        /* highest precedence */
%start main             /* the entry point */
%type <Expressions.expr> main
%%
main:
  | ENTER LBRACE expr RBRACE EXIT { $3 }
;

expr:
  | INT { Int $1 }
  | VAR { Var $1 }
  | TRUE { Boolean true }
  | FALSE { Boolean false }
  | LPAREN expr RPAREN { $2 }
  | expr PLUS expr { Plus($1, $3) }
  | expr MINUS expr { Minus($1, $3) }
  | expr MULTIPLY expr { Multiply($1, $3) }
  | expr DIVIDE expr { Divide($1, $3) }
  | expr POWER expr { Power($1, $3) }
  | expr MOD expr { Mod($1, $3) }
  | expr EQ expr { Eq($1, $3) }
  | expr NEQ expr { Neq($1, $3) }
  | expr LE expr { Le($1, $3) }
  | expr LQ expr { Lq($1, $3) }
  | expr GE expr { Ge($1, $3) }
  | expr GQ expr { Gq($1, $3) }
  | expr AND expr { And($1, $3) }
  | expr OR expr { Or($1, $3) }
  | IF LPAREN expr RPAREN THEN expr ELSE expr { If($3, $6, $8) }
;
