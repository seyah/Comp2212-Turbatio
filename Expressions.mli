type name = string
type expr =
  | Var of name
  | Int of int
  | Plus of expr * expr
  | Minus of expr * expr
  | Multiply of expr * expr
  | Divide of expr * expr
  | Power of expr * expr
  | Mod of expr * expr
  | Boolean of bool
  | Eq of expr * expr
  | Neq of expr * expr
  | Le of expr * expr
  | Lq of expr * expr
  | Ge of expr * expr
  | Gq of expr * expr
  | And of expr * expr
  | Or of expr * expr
  | If of expr * expr * expr
