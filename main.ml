open Expressions
open Lexer
open Parser
open Arg
open Printf
open List
open Lexing

exception EvaluationError of string ;;
exception LookupError ;;
exception Terminated ;;

type 'a context = Env of (string * 'a) list ;;

module Variables = Map.Make(String) ;;
let pipe_values = ref Variables.empty ;;
let global_values = ref Variables.empty ;;
let lstLength = ref 0 ;;
let lstCount = ref 0 ;;

let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d:%d" pos.pos_fname
    pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1) pos.pos_bol
;;

let isValue e = match e with
  | TurInt e -> true
  | TurBoolean e -> true
  | TurVar e -> true
  | _ -> false
;;

let fetchVar str =
  try
    int_of_string (Variables.find str !global_values)
  with Not_found -> raise LookupError
;;

let fetchPipe str =
  try
    int_of_string (Variables.find str !pipe_values)
  with Not_found -> raise LookupError
;;

let get_res res = match res with
  | TurInt i -> TurInt(i)
  | TurBoolean b -> TurBoolean(b)
  | TurVar s -> TurInt(fetchVar s)
  | _ -> raise (EvaluationError "Not of type Int or Boolean")
;;

let rec get_res_as_string res = match res with
  | TurInt i -> string_of_int i
  | TurBoolean b -> string_of_bool b
  | TurVar s -> string_of_int (fetchVar s)
  | _ -> raise (EvaluationError "Not of type Int or Boolean")
;;

let get_res_as_int res = match res with
  | TurInt i -> i
  | _ -> raise (EvaluationError "Not of type Int")
;;

let get_res_as_boolean res = match res with
  | TurBoolean b -> b
  | _ -> raise (EvaluationError "Not of type Boolean")
;;

let read_bind_line = function
  | _ -> try
        let line = read_line() in
        if line <> "" then
          let nums = ref (Str.split (Str.regexp " ") line) in
          lstCount := (List.length !nums);
          for i = 0 to (List.length !nums) - 1 do
            pipe_values := (Variables.add ("lst" ^ (string_of_int i)) (List.nth !nums i) !pipe_values)
          done;
      with
      | _ -> raise (EvaluationError "Line could not be read. Has the file ended?")
;;

let read_from_pipe n = match n with
  | int -> try
        for i = 1 to n do
          read_bind_line ();
        done;
      with End_of_file -> ()
;;

let reset_pipe n = match n with
  | int -> seek_in stdin n
;;

let get_pipe_lengths =
  reset_pipe 0;
  let i = ref 0 in
  try
    while true do
      let line = read_line() in
      if line <> "" then
        let nums = ref (Str.split (Str.regexp " ") line) in
        lstCount := (List.length !nums);
        i := !i + 1;
    done;
    lstLength := !i;
  with End_of_file -> reset_pipe 0; lstLength := !i;
;;

let assign_var str e =
  global_values := (Variables.add str e !global_values); TurInt (int_of_string e)
;;

let rec evalloop e = try (let (e') = (eval e) in (evalloop e')) with Terminated -> if (isValue e) then e else exit(-1)
and eval e = match e with
  | TurInt n -> raise Terminated
  | TurBoolean b -> raise Terminated
  | TurVar x -> (try (TurInt(fetchVar x)) with LookupError -> raise (EvaluationError ("Variable could not be found: " ^ x)))
  | TurLst l -> (try (TurInt(fetchPipe ("lst" ^ (get_res_as_string l)))) with LookupError -> raise (EvaluationError "List stream could not be found."))

  | TurPrint s -> print_string ((get_res_as_string (evalloop s)) ^ " ") ; (TurBoolean(true))
  | TurResetPipe n -> reset_pipe (get_res_as_int (evalloop n)); (TurBoolean(true))
  | TurPrintNl -> print_newline () ; (TurBoolean(true))
  | TurReadNl -> read_from_pipe 1 ; (TurBoolean(true))
  | TurPipeLength -> (TurInt(!lstLength))
  | TurPipeCount -> (TurInt(!lstCount))

  | TurAssign(s, TurInt(n)) -> assign_var s (string_of_int n) ;
  | TurAssign(s, e1) -> let (e1') = (evalloop e1) in assign_var s (get_res_as_string e1') ;

  | TurSeq (e1, e2) -> ignore (eval e1) ; eval e2

  | TurPlus(TurInt(n), TurInt(m)) -> (TurInt( n + m ))
  | TurPlus(TurInt(n), e2) -> let (e2') = (eval e2) in (TurPlus(TurInt(n), e2'))
  | TurPlus(e1, e2) -> let (e1') = (eval e1) in (TurPlus(e1', e2))

  | TurMinus(TurInt(n), TurInt(m)) -> (TurInt( n - m ))
  | TurMinus(TurInt(n), e2) -> let (e2') = (eval e2) in (TurMinus(TurInt(n), e2'))
  | TurMinus(e1, e2) -> let (e1') = (eval e1) in (TurMinus(e1', e2))

  | TurMultiply(TurInt(n), TurInt(m)) -> (TurInt( n * m ))
  | TurMultiply(TurInt(n), e2) -> let (e2') = (eval e2) in (TurMultiply(TurInt(n), e2'))
  | TurMultiply(e1, e2) -> let (e1') = (eval e1) in (TurMultiply(e1', e2))

  | TurDivide(TurInt(n), TurInt(m)) -> (TurInt( n / m ))
  | TurDivide(TurInt(n), e2) -> let (e2') = (eval e2) in (TurDivide(TurInt(n), e2'))
  | TurDivide(e1, e2) -> let (e1') = (eval e1) in (TurDivide(e1', e2))

  | TurMod(TurInt(n), TurInt(m)) -> (TurInt( n mod m ))
  | TurMod(TurInt(n), e2) -> let (e2') = (eval e2) in (TurMod(TurInt(n), e2'))
  | TurMod(e1, e2) -> let (e1') = (eval e1) in (TurMod(e1', e2))

  | TurNegate(TurInt(n)) -> (TurInt( - n ))
  | TurNegate(e1) -> let (e1') = (eval e1) in (TurNegate(e1'))

  | TurEq(TurInt(n), TurInt(m)) -> (TurBoolean( n = m ))
  | TurEq(TurInt(n), e2) -> let (e2') = (eval e2) in (TurEq(TurInt(n), e2'))
  | TurEq(e1, e2) -> let (e1') = (eval e1) in (TurEq(e1', e2))

  | TurNeq(TurInt(n), TurInt(m)) -> (TurBoolean( n <> m ))
  | TurNeq(TurInt(n), e2) -> let (e2') = (eval e2) in (TurNeq(TurInt(n), e2'))
  | TurNeq(e1, e2) -> let (e1') = (eval e1) in (TurNeq(e1', e2))

  | TurLe(TurInt(n), TurInt(m)) -> (TurBoolean( n < m ))
  | TurLe(TurInt(n), e2) -> let (e2') = (eval e2) in (TurLe(TurInt(n), e2'))
  | TurLe(e1, e2) -> let (e1') = (eval e1) in (TurLe(e1', e2))

  | TurLq(TurInt(n), TurInt(m)) -> (TurBoolean( n <= m ))
  | TurLq(TurInt(n), e2) -> let (e2') = (eval e2) in (TurLq(TurInt(n), e2'))
  | TurLq(e1, e2) -> let (e1') = (eval e1) in (TurLq(e1', e2))

  | TurGe(TurInt(n), TurInt(m)) -> (TurBoolean( n > m ))
  | TurGe(TurInt(n), e2) -> let (e2') = (eval e2) in (TurGe(TurInt(n), e2'))
  | TurGe(e1, e2) -> let (e1') = (eval e1) in (TurGe(e1', e2))

  | TurGq(TurInt(n), TurInt(m)) -> (TurBoolean( n >= m ))
  | TurGq(TurInt(n), e2) -> let (e2') = (eval e2) in (TurGq(TurInt(n), e2'))
  | TurGq(e1, e2) -> let (e1') = (eval e1) in (TurGq(e1', e2))

  | TurAnd(TurBoolean(n), TurBoolean(m)) -> (TurBoolean( n && m ))
  | TurAnd(TurBoolean(n), e2) -> let (e2') = (eval e2) in (TurAnd(TurBoolean(n), e2'))
  | TurAnd(e1, e2) -> let (e1') = (eval e1) in (TurAnd(e1', e2))

  | TurOr(TurBoolean(n), TurBoolean(m)) -> (TurBoolean( n || m ))
  | TurOr(TurBoolean(n), e2) -> let (e2') = (eval e2) in (TurOr(TurBoolean(n), e2'))
  | TurOr(e1, e2) -> let (e1') = (eval e1) in (TurOr(e1', e2))

  | TurWhile(b, e1) -> while get_res_as_boolean (evalloop b) do evalloop e1; done; TurBoolean(true)

  | TurLoopStream(e1) -> if(!lstLength <> 0) then begin
        for i = 0 to !lstLength -1 do
          (read_from_pipe 1); evalloop e1;
        done; end; TurBoolean(true)

  | TurIf(TurBoolean(true), e1) -> (eval e1)
  | TurIf(b, e1) -> let (b') = (eval b) in (TurIf(b', e1))

  | TurIfElse(TurBoolean(true), e1, e2) -> (eval e1)
  | TurIfElse(TurBoolean(false), e1, e2) -> (eval e2)
  | TurIfElse(b, e1, e2) -> let (b') = (eval b) in (TurIfElse(b', e1, e2))
;;

let evalProg e = evalloop e ; ();;

let () =
  get_pipe_lengths;
  let lexbuf = Lexing.from_channel (open_in Sys.argv.(1)) in
  try
    let result = (Parser.top Lexer.token lexbuf) in
    List.iter evalProg result;
    ();
  with
  | Parsing.Parse_error -> fprintf stderr "%a: syntax error\n" print_position lexbuf;
      exit (-1)
;;

flush stdout ;;