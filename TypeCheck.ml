exception LookupError ;;
exception TypeError ;;

(* Types of the language *)
type turType = TurInt | TurBool | TurFun of turType * turType

(* Type of Environments *)

type 'a context = Env of (string * 'a) list
type typeContext = turType context
type valContext = expr context

(* Function to look up the type of a string name variable in a type environment *)
let rec lookup env str = match env with
   Env [] -> raise LookupError
  |Env ((name,thing) :: gs) ->
        (
          match (name = str) with
            true -> thing
           |false -> lookup (Env (gs)) str
	)
;;

(* Function to add an extra entry in to an environment *)
let addBinding env str thing = match env with
      Env(gs) -> Env ( (str, thing) :: gs ) ;;


(* Type checking function *)
(* The type checking function itself *)
let rec typeOf env e = match e with
   Int (n) -> TurInt

  |Boolean (b) -> TurBool

  |Var (x) ->  (try lookup env x with LookupError -> raise TypeError)

  |Plus (e1,e2) ->
    (
     match (typeOf env e1) , (typeOf env e2) with
             TurInt, TurInt -> TurInt
                    |_ -> raise TypeError
    )

  |Minus (e1,e2) ->
    (
      match (typeOf env e1) , (typeOf env e2) with
        TurInt, TurInt -> TurInt
          |_ -> raise TypeError
      )

  |Multiply (e1,e2) ->
    (
      match (typeOf env e1) , (typeOf env e2) with
        TurInt, TurInt -> TurInt
          |_ -> raise TypeError
      )

  |Divide (e1,e2) ->
    (
      match (typeOf env e1) , (typeOf env e2) with
        TurInt, TurInt -> TurInt
          |_ -> raise TypeError
      )

  |Power (e1,e2) ->
    (
      match (typeOf env e1) , (typeOf env e2) with
        TurInt, TurInt -> TurInt
          |_ -> raise TypeError
      )

  |Mod (e1,e2) ->
    (
      |Power (e1,e2) ->
        (
          match (typeOf env e1) , (typeOf env e2) with
            TurInt, TurInt -> TurInt
              |_ -> raise TypeError
          )
      )

  
