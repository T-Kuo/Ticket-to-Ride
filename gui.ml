open Action
open Game

(* Starting GUI page, choose number of players *)
let start_page () =
  (* Text and 5 buttons *)


let filler () = ["a";"b";"c"]
(* Global refences to drop down objects *)
let select_c0 = ref (GEdit.combo ~popdown_strings:(filler ()) ())
let select_c1 = ref (GEdit.combo ~popdown_strings:(filler ()) ())

(* Global references to face up card objects *)

(* Global references to check button clicking *)
let draw0 = ref (false)
let draw1 = ref (false)
let draw2 = ref (false)
let draw3 = ref (false)
let draw4 = ref (false)
let draw_deck = ref (false)
let claim_route = ref (false)
let req_tickets = ref (false)

(* match [color] with correct card image *)
let match_jpg color =
  match color with
  | Color.Rainbow -> "images/rainbow_card.jpg"
  | Color.Red -> "images/red_card.jpg"
  | Color.Blue -> "images/blue_card.jpg"
  | Color.Yellow -> "images/yellow_card.jpg"
  | Color.Green -> "images/green_card.jpg"
  | Color.Orange -> "images/orange_card.jpg"
  | Color.Pink -> "images/pink_card.jpg"
  | Color.White -> "images/white_card.jpg"
  | Color.Black -> "images/black_card.jpg"

let main_gui () =
  select_c0 := GEdit.combo ~popdown_strings:(Board.cnames_list ())
    ~case_sensitive:false ~allow_empty:false
      ~packing:(???) ();

  select_c1 := GEdit.combo ~popdown_strings:(Board.cnames_list ())
    ~case_sensitive:false ~allow_empty:false
      ~packing:(???) ();
  (* Add current player text*)
  (* Add new game button *)

(* matches color string and returns corresponding type Color *)
let get_color color_str =
  match color_str with
  | "colorless" -> Color.Colorless
  | "rainbow" -> Color.Rainbow
  | "red" -> Color.Red
  | "blue" -> Color.Blue
  | "yellow" -> Color.Yellow
  | "green" -> Color.Green
  | "orange" -> Color.Orange
  | "pink" -> Color.Pink
  | "white" -> Color.White
  | "black" -> Color.Black

(* returns routes between city strings [s0] and [s1] on board [b] with
 * matching color [color] in a list *)
let get_colorroutes s0 s1 b color =
  let all_routes = Board.routes_between_string s0 s1 b in
  List.filter (fun x -> x.color=color && x.owner=None) all_routes

(* processes commands from human player and returns an action *)
let rec do_turn board p ticket_hand train_hand deck trains rainbow =
  (* Update GUI state *)

  (* Change current player *)

  let rainbow_num = Card.hand_has Color.Rainbow train_hand in
  let red_num = Card.hand_has Color.Red train_hand in
  let blue_num = Card.hand_has Color.Blue train_hand in
  let yellow_num = Card.hand_has Color.Yellow train_hand in
  let green_num = Card.hand_has Color.Green train_hand in
  let orange_num = Card.hand_has Color.Orange train_hand in
  let pink_num = Card.hand_has Color.Pink train_hand in
  let white_num = Card.hand_has Color.White train_hand in
  let black_num = Card.hand_has Color.Black train_hand in
   (* update counter *);
  let face_ups = deck.faceup in
   (* change button labels *)

  (* Drawing a face up train card *)
  if (!draw0) then (
    draw0 := false;
    DrawFaceUp 0)
  else if (!draw1) then (
    draw1 := false;
    DrawFaceUp 1)
  else if (!draw2) then (
    draw2 := false;
    DrawFaceUp 2)
  else if (!draw3) then (
    draw3 := false;
    DrawFaceUp 3)
  else if (!draw4) then (
    draw4 := false;
    DrawFaceUp 4)
  (* Drawing a train card from deck *)
  else if (!draw_deck) then (
    draw_deck := false;
    DrawDeck)
  (* Claiming a route *)
  else if (!claim_route) then (
    claim_route := false;
    let route_color = get_color (!select_color#entry#text) in
    let chosen_route =
      get_colorroutes (!select_c0#entry#text) (!select_c1#entry#text) board route_color in
    if (chosen_route <> []) then ClaimRoute (List.hd chosen_route) route_color
    else (
      Printf.printf "No available routes, pick a different route";
      do_turn board p ticket_hand train_hand deck trains rainbow)
  )
  (* Requesting ticket cards *)
  else if (!req_tickets) then (
    req_tickets := false;
    RequestTickets)
  (* Wait for human player's turn *)
  else do_turn board p ticket_hand train_hand deck trains rainbow

let () = start_page (); main_gui ()