open DrawingType
      
let simple_triangle =
  let pi23 = 2.0 *. pi /. 3.0 in
    Forward 25.0 :: Turn pi23 ::
    Forward 25.0 :: Turn pi23 ::
    Forward 25.0 :: []

let simple_square = 
  Forward 25.0 :: Turn pi2 ::
  Forward 25.0 :: Turn pi2 ::
  Forward 25.0 :: Turn pi2 ::
  Forward 25.0 :: []

let pentagone = 
  let pi25 = 2.0 *. pi /. 5.0 in
    Forward 25.0 :: Turn pi25 ::
    Forward 25.0 :: Turn pi25 ::
    Forward 25.0 :: Turn pi25 ::
    Forward 25.0 :: Turn pi25 ::
    Forward 25.0 :: []

let rec polygone_aux = fun n t ->
  if (n<=0) then []
  else
  Forward 25.0 :: Turn (2.0 *. pi /. t) ::
  polygone_aux (n-1) t

let polygone n = 
  polygone_aux n (float_of_int n)

let rec square_spiral = fun n d ->
  if(n<=0) then []
  else
  Forward d :: Turn pi2 ::
  square_spiral (n-1) (d *. 0.8)

let rec spiral_log = fun n d roh l ->
  if(n<=0) then l
  else
   Forward d :: Turn roh :: (spiral_log (n-1) (d*.0.8) roh (Turn (-. roh) :: Forward (-. d) :: l))


let rec tree = fun n d roh l ->
  if(n<=0) then l
  else
      Forward d :: Turn (-.roh) :: ( tree (n-1) (d*.0.5) roh (Turn (roh) :: Forward (-.d) :: 
        Forward d :: Turn (roh) :: (tree (n-1) (d*.0.8) (roh) (Turn (-.roh) :: Forward (-.d) :: l) ) ) )

let rec dragon_left = fun n d l->
  if(n<=0) then Forward d :: l
  else 
      Turn (pi4) ::  (dragon_right (n-1) (d*. (sqrt(2.)/. 2.)) 
                                   (Turn (-.pi4) :: Turn (-. pi4) :: (dragon_left (n-1) (d*. (sqrt(2.)/. 2.)) 
                                                                                  (Turn pi4 :: l) ) ) )
                      
and

dragon_right = fun n d l->
  if (n<=0) then Forward d :: l
  else 
      Turn (-.pi4) :: (dragon_right (n-1) (d*. (sqrt(2.)/. 2.)) 
                                    (Turn pi4 :: Turn pi4 :: (dragon_left (n-1) (d*. (sqrt(2.)/.2.)) 
                                                                          (Turn (-.pi4) :: l) ) ) )
                          

let draw = fun n ->
  dragon_right n 10. []
  (*tree n 20. (pi /. 4.) []*)