let pi = 4.0 *.atan 1.0 
let pi2 = (pi/.2.0)
let pi4 = (pi/.4.0)
let pi3 = (pi/.3.0)
      

type point = float*float

type geom = 
  | Forward of float
  | Turn of float
(*  | SetPencil of bool
  | Text of string*)

type path = geom list
               
let string_of_point = fun (x,y) ->
  Printf.sprintf "(%g,%g)" x y
               
let string_of_geom = fun x ->
  match x with
  | Forward f -> "Forward "^(string_of_float f)
  | Turn f -> "Turn "^(string_of_float f)
(*  | SetPencil b -> "SetPencil "^(string_of_bool b)
  | Text t -> "Text "^t*)

let string_of_path l =
  let s = List.fold_left (fun s g ->
              let gs = string_of_geom g in
              if s="" then "["^gs else s^"; "^gs) "" l in
  s ^ "]"
