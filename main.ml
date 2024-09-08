open DrawingType

let add (x1,y1) (x2,y2) = (x1+.x2,y1+.y2)
let pt_of_point (x,y) =
  int_of_float (x *. (float (Graphics.size_x ())) /. 100.0),
  int_of_float (y *. (float (Graphics.size_y ())) /. 100.0)

let set_color_progress f =
  let v = f *. float (1 lsl (8*2)) (*+. (1.0-.f) *. float (1 lsl (8*3)  )*)  in
  Graphics.set_color (int_of_float v)

let set_color_progress_2 f =
  let g,b = if f<0.5 then f/.0.5 , (0.5 -.f) /. 0.5
            else (1.-.f) /. 0.5, (f-.0.5)/.0.5 in
  let r = int_of_float (f*. 256.)
  and g2 = int_of_float (g*. 256.)
  and b2 = int_of_float (b*. 256. ) in
  Printf.printf " r %i  g %i b %i" r g2 b2;
  print_newline ();
  Graphics.set_color ((r lsr 16) + (g2 lsr 8) + b2)  


let display n l =
  Graphics.clear_graph ();
  Graphics.moveto 10 10;
  set_color_progress 0.0;
  let total_drawing = List.length l in
  Graphics.draw_string (Printf.sprintf "n=%i; nbgeom=%i" n total_drawing);
  let pt = (50.0,50.0) in
  let x1,y1 = pt_of_point pt in
  Graphics.moveto x1 y1;
  ignore (List.fold_left (fun (n,pencil,rho,pt) x ->
      if n mod 50000 =0 then Graphics.synchronize ();
      set_color_progress (float n /. (float total_drawing));
      match x with
      | Forward f -> 
        let pt2 = add pt (f*.(cos rho), f*.(sin rho)) in
        let x2,y2 = pt_of_point pt2 in
        if pencil then Graphics.lineto x2 y2
        else Graphics.moveto x2 y2;
        (n+1,pencil,rho,pt2)
      | Turn r -> (n+1,pencil,rho+.r,pt)
      (*| SetPencil b -> (n+1,b,rho,pt)
      | Text t -> 
         Graphics.draw_string t;
         let x,y = pt_of_point pt in
         Graphics.moveto x y;
         (n+1,pencil,rho,pt)*)
    ) (0,true,pi2,pt) l);
  Graphics.synchronize ()


let rec iter f n =
  let _ = display n (f n) in
  ignore (Graphics.wait_next_event [Graphics.Button_down; Graphics.Key_pressed]);
  set_color_progress 0.0;
  Graphics.moveto 200 10;
  Graphics.draw_string "En cours de calcul ...";
  Graphics.synchronize ();
  iter f (n+1)

let dessine =
  Graphics.open_graph " 500x500";
  Graphics.auto_synchronize false;
  try iter Draw.draw 0 with Graphics.Graphic_failure _ -> ()
