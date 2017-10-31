type variableType = TurbatioInt | TurbatioBoolean

type expr =
  | TurVar of string
  | TurInt of int
  | TurBoolean of bool
  | TurPlus of expr * expr
  | TurMinus of expr * expr
  | TurMultiply of expr * expr
  | TurDivide of expr * expr
  | TurMod of expr * expr
  | TurNegate of expr
  | TurEq of expr * expr
  | TurNeq of expr * expr
  | TurLe of expr * expr
  | TurLq of expr * expr
  | TurGe of expr * expr
  | TurGq of expr * expr
  | TurAnd of expr * expr
  | TurOr of expr * expr
  | TurLst of expr
  | TurPrint of expr
  | TurResetPipe of expr
  | TurPipeLength
  | TurPipeCount
  | TurPrintNl
  | TurReadNl
  | TurWhile of expr * expr
  | TurLoopStream of expr
  | TurIf of expr * expr
  | TurIfElse of expr * expr * expr
  | TurSeq of expr * expr
  | TurAssign of string * expr