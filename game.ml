open Async.Std
open Action
open Board
open Card
open Color
open Player

type player_state = {
  pid : Player.player;
  ptype : Player.player_type;
  color : Color.color;
  train_hand : TrainCard.hand;
  ticket_hand : TicketCard.hand;
  trains_left : int;
  score : int
  }

type state = {
  board: Board.board;
  train_deck : TrainCard.deck;
  ticket_deck : TicketCard.deck;
  player_info : player_state list
  }

let current_state = ref ({board = new_board; train_deck = TrainCard.new_deck;
ticket_deck = TicketCard.new_deck; player_info = []})
let human_action = ref (Ivar.create ())
let current_gui_state = ref (Ivar.create ())

(* checks if a player is a human player *)
let rec human_player p state =
  match state.player_info with
  |[] -> failwith "No such player."
  |pl::ps ->
    if pl.pid = p then pl.ptype = Human
    else human_player p {state with player_info = ps}

(* the hand of a player in a given state of the game *)
let rec player_hand p state =
  match state.player_info with
  |[] -> failwith "No such player."
  |pl::ps ->
    if pl.pid = p then pl.train_hand
    else player_hand p {state with player_info = ps}

(* Calculates a player's score, without the longest route bonus.*)
let rec calculate_score p routes scr =
  match routes with
  |[] -> scr
  |h::t -> if h.owner = p then
            match h.length with
            |1 -> calculate_score p t (scr+1)
            |2 -> calculate_score p t (scr+2)
            |3 -> calculate_score p t (scr+4)
            |4 -> calculate_score p t (scr+7)
            |5 -> calculate_score p t (scr+10)
            |6 -> calculate_score p t (scr+15)
           else calculate_score p t scr

(* gets the card at index i in the list of faceup cards.*)
let rec cindex x i lst =
  match lst with
  |[] -> failwith "index out of range"
  |h::t -> if x = i then h else cindex x (i+1) t

(* removes [n] from list [lst], returns [lst] if list has no [n] *)
let rec remove_n lst n =
  match lst with
  |[] -> []
  |h::t -> if n = h then t else h::(remove_n t n)


(* the state of the game after a turn is taken *)
let rec do_turn i state =
  current_gui_state := Ivar.create ();
  let pl = List.hd state.player_info in
  if i = 1 then (
  match  pl.ptype with
  |Human ->
    upon (Ivar.read !human_action) (fun a ->
    let i = execute_turn state a 0 in human_action := Ivar.create (); do_turn i !current_state);
  |AI -> let a = (Ai.do_turn state.board pl.ticket_hand pl.train_hand
    state.train_deck.faceup pl.pid true) in
    let i = execute_turn state a 0 in do_turn i !current_state)
  else (
  current_gui_state := Ivar.create ();
  let pl = List.hd state.player_info in
  match pl.ptype with
  |Human ->
    upon (Ivar.read !human_action) (fun a ->
    let i = execute_turn state a 1 in human_action := Ivar.create (); do_turn i !current_state);
  |AI -> let a = (Ai.do_turn state.board pl.ticket_hand pl.train_hand
    state.train_deck.faceup pl.pid true) in
    let i = execute_turn state a 1 in do_turn i !current_state)
and execute_turn state action num =
  match num with
  |0 -> (
    match action with
    | DrawFaceUp n ->
      let pl = List.hd state.player_info in
      let cd = cindex n 0 state.train_deck.faceup in
      let rfu = remove_n (state.train_deck.faceup) cd in
      (match cd with
      |Rainbow ->
        let dr = List.hd state.train_deck.draw_pile in
        let nfu = dr::rfu in
        let nd = {state.train_deck with
                  draw_pile = List.tl state.train_deck.draw_pile;
                  faceup = nfu} in
        let np = {pl with train_hand = (TrainCard.add_to_hand cd pl.train_hand)} in
        let ns = {state with
        player_info = (List.tl state.player_info) @ [np];
        train_deck = nd} in
        current_state := ns;
        let pl = List.hd ns.player_info in
        Ivar.fill !current_gui_state (ns.board, pl.pid, pl.ticket_hand,
      pl.train_hand, ns.train_deck.faceup, pl.trains_left, true);
        1
      |_ ->
        let dr = List.hd state.train_deck.draw_pile in
        let nfu = dr::rfu in
        let nd = {state.train_deck with
                  draw_pile = List.tl state.train_deck.draw_pile;
                  faceup = nfu} in
        let np = {pl with train_hand = (TrainCard.add_to_hand cd pl.train_hand)} in
        let ns = {state with
        train_deck = nd;
        player_info = np::(List.tl state.player_info)} in
        current_state := ns;
        Ivar.fill !current_gui_state (ns.board, np.pid, np.ticket_hand,
      np.train_hand, ns.train_deck.faceup, np.trains_left, true);
        2)

    | DrawDeck ->
      let pl = List.hd state.player_info in
      let cd = List.hd state.train_deck.draw_pile in
      let nd = {state.train_deck with draw_pile =
                List.tl (state.train_deck.draw_pile)} in
      let np = {pl with train_hand = (TrainCard.add_to_hand cd pl.train_hand)} in
      let ns = {state with
                train_deck = nd;
                player_info = np::(List.tl state.player_info)} in
      current_state := ns;
      Ivar.fill !current_gui_state (ns.board, np.pid, np.ticket_hand,
      np.train_hand, ns.train_deck.faceup, np.trains_left, true);
      2
    | ClaimRoute (rt,c) ->
      let pl = List.hd state.player_info in
      (match (Board.claim_route pl.pid rt state.board) with
      |true, bd ->
        let np = {pl with
                  trains_left = (pl.trains_left - rt.length);
                  score = (calculate_score pl.pid bd.routes 0)} in
        (*Check if # of trains left is below limit. If so call determine winner. End Game.*)
        let ns = {state with
                  board = bd;
                  player_info = (List.tl state.player_info) @ [np]} in
        current_state := ns;
        let pl = List.hd ns.player_info in
        Ivar.fill !current_gui_state (ns.board, pl.pid, pl.ticket_hand,
      pl.train_hand, ns.train_deck.faceup, pl.trains_left, true);
        1
      |false, bd ->
        (*Display message saying this route can't be claimed.*)
        1)

    | RequestTickets ->
      let pl = List.hd state.player_info in
      let cd = List.hd state.ticket_deck.draw_pile in
      let nd = {state.ticket_deck with draw_pile =
                (List.tl state.ticket_deck.draw_pile)} in
      let np = {pl with ticket_hand = cd::pl.ticket_hand} in
      let ns = {state with
        player_info = (List.tl state.player_info) @ [np];
        ticket_deck = nd} in
      current_state := ns;
      let pl = List.hd ns.player_info in
      Ivar.fill !current_gui_state (ns.board, pl.pid, pl.ticket_hand,
      pl.train_hand, ns.train_deck.faceup, pl.trains_left, true);
        1
    )
  |1 -> (
    match action with
    | DrawFaceUp n ->
      let pl = List.hd state.player_info in
      let cd = cindex n 0 state.train_deck.faceup in
      let rfu = remove_n (state.train_deck.faceup) cd in
      (match cd with
      |Rainbow ->
        (*Display message saying this card cannot be taken.*)
        2

      |_ ->
        let dr = List.hd state.train_deck.draw_pile in
        let nfu = dr::rfu in
        let nd = {state.train_deck with
                  draw_pile = List.tl state.train_deck.draw_pile;
                  faceup = nfu} in
        let np = {pl with train_hand = (TrainCard.add_to_hand cd pl.train_hand)} in
        let ns = {state with
        train_deck = nd;
        player_info = (List.tl state.player_info) @ [np]} in
        current_state := ns;
        let pl = List.hd ns.player_info in
        Ivar.fill !current_gui_state (ns.board, pl.pid, pl.ticket_hand,
      pl.train_hand, ns.train_deck.faceup, pl.trains_left, true);
        1)
    | DrawDeck ->
      let pl = List.hd state.player_info in
      let cd = List.hd state.train_deck.draw_pile in
      let nd = {state.train_deck with draw_pile =
                (List.tl state.train_deck.draw_pile)} in
      let np = {pl with train_hand = (TrainCard.add_to_hand cd pl.train_hand)} in
      let ns = {state with
                train_deck = nd;
                player_info = (List.tl state.player_info) @ [np]} in
      current_state := ns;
      let pl = List.hd ns.player_info in
      Ivar.fill !current_gui_state (ns.board, pl.pid, pl.ticket_hand,
      pl.train_hand, ns.train_deck.faceup, pl.trains_left, true);
      1

    | ClaimRoute (rt,c) ->
      (*Display message saying this action cannot be performed.*)
      1

    | RequestTickets ->
      (*Display message saying this action cannot be performed.*)
      1
    )

(* the score of a player in a given state of the game *)
let rec score_player p state =
  match state.player_info with
  |[] -> failwith "No such player."
  |pl::ps ->
    if pl.pid = p then pl.score
    else score_player p {state with player_info = ps}

(* the winner of the game in a given game state, if game is tied, returns
 * one of the players who is tied. *)
let determine_winner state =
  let rec help cw cs state =
    match state.player_info with
    |[] -> cw
    |pl::ps ->
      if pl.score > cs then
        help pl.pid pl.score {state with player_info = ps}
      else help cw cs {state with player_info = ps} in

  help None 0 state

let main =
  (*Ask for user input, number of human players. Rest will be AI.
   * min 1 human player, max 5. There are 5 players per game.*)
  let humans = ref 5 in
  let pl1 = { pid = Player1;
              ptype = if !humans = 0 then AI else (humans := (!humans -1); Human);
              color = Red;
              train_hand = {rainbow=0;red=0;blue=0;yellow=0;green=0;orange=0;
                            pink=0;white=0;black=0};
              ticket_hand = [];
              trains_left = 70;
              score = 0} in
  let pl2 = { pid = Player2;
              ptype = if !humans = 0 then AI else (humans := (!humans -1); Human);
              color = Blue;
              train_hand = {rainbow=0;red=0;blue=0;yellow=0;green=0;orange=0;
                            pink=0;white=0;black=0};
              ticket_hand = [];
              trains_left = 70;
              score = 0} in
  let pl3 = { pid = Player3;
              ptype = if !humans = 0 then AI else (humans := (!humans -1); Human);
              color = Green;
              train_hand = {rainbow=0;red=0;blue=0;yellow=0;green=0;orange=0;
                            pink=0;white=0;black=0};
              ticket_hand = [];
              trains_left = 70;
              score = 0} in
  let pl4 = { pid = Player4;
              ptype = if !humans = 0 then AI else (humans := (!humans -1); Human);
              color = Yellow;
              train_hand = {rainbow=0;red=0;blue=0;yellow=0;green=0;orange=0;
                            pink=0;white=0;black=0};
              ticket_hand = [];
              trains_left = 70;
              score = 0} in
  let pl5 = { pid = Player5;
              ptype = if !humans = 0 then AI else (humans := (!humans -1); Human);
              color = Black;
              train_hand = {rainbow=0;red=0;blue=0;yellow=0;green=0;orange=0;
                            pink=0;white=0;black=0};
              ticket_hand = [];
              trains_left = 70;
              score = 0} in
  let pinfo = [pl1;pl2;pl3;pl4;pl5] in
  let board = Board.new_board in
  let trkd = TrainCard.new_deck in
  let tikd = TicketCard.new_deck in
  let state = {player_info = pinfo; board = board;
                train_deck = trkd; ticket_deck = tikd} in
  (* Display welcome message or something *)
  current_state := state;
  Ivar.fill !current_gui_state (state.board, pl1.pid, pl1.ticket_hand,
      pl1.train_hand, state.train_deck.faceup, pl1.trains_left, true);
  printf "Initializing GUI, start game\n%!";
  let _ = Gui.main_gui current_gui_state human_action () in
  do_turn 1 state

let _ = main
let _ = Scheduler.go ()