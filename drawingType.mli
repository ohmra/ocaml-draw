val pi : float
val pi2 : float
val pi3 : float
val pi4 : float
  
type point = float * float
type geom =
  | Forward of float
  | Turn of float
(*  | SetPencil of bool
  | Text of string*)

type path = geom list
val string_of_point : point -> string
val string_of_geom : geom -> string
val string_of_path : path -> string
