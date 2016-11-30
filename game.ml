open Board
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

(* the state of the game after a turn is taken *)
let do_turn state =
  let pl = state.player_info in
  match pl.ptype with
  |Human ->
  |AI ->

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
      if pl.score > currscr then
        help pl.pid pl.score {state with player_info = ps}
      else help currwin currscr {state with player_info = ps} in

  help None 0 state

let main () =
  failwith "unimplemented"