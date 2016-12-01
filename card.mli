(* A [Card] implementation that manipulates the train cards in Ticket to Ride *)
module TrainCard : sig
	  (* the type of a Ticket to Ride card *)
	type t = Color.color
	(* the type of a hand *)
	type hand = {rainbow:int;red:int;blue:int;yellow:int;green:int;orange:int;
		pink:int;white:int;black:int}
	(* the type of a deck of cards *)
	type deck = {draw_pile: t list; discard_pile: t list; faceup : t list}

  (* [new_deck] is a new deck of cards *)
	val new_deck : deck

	val empty_hand : hand

  (* checks if a deck of cards is empty *)
	val is_empty : deck -> bool

  (* draws a card from a deck *)
	val draw : deck ->  t option * deck

  (* adds a card to the discard pile *)
	val discard : t -> deck -> deck

  (* checks if a hand contains at least a card of the same type as t *)
	val hand_contains : t -> hand -> bool

  (* adds a card to a hand *)
	val add_to_hand : t -> hand -> hand

  (* removes a card from a hand *)
	val remove_from_hand : t -> hand -> hand

  (* shuffles a deck of cards *)
	val shuffle : deck -> deck
	(*val difference : hand -> hand -> hand*)
end

(* A [Card] implementation that manipulates the ticket cards in Ticket to Ride *)
module TicketCard : sig
	  (* the type of a Ticket to Ride card *)
	type t = {c0 : Board.city; c1 : Board.city; points : int}
	(* the type of a hand *)
	type hand = t list
	(* the type of a deck of cards *)
	type deck = {draw_pile : t list; discard_pile : t list}

  (* [new_deck] is a new deck of cards *)
	val new_deck : deck

	val empty_hand : hand

  (* checks if a deck of cards is empty *)
	val is_empty : deck -> bool

  (* draws a card from a deck *)
	val draw : deck ->  t option * deck

  (* adds a card to the discard pile *)
	val discard : t -> deck -> deck

  (* checks if a hand contains at least a card of the same type as t *)
	val hand_contains : t -> hand -> bool

  (* adds a card to a hand *)
	val add_to_hand : t -> hand -> hand

  (* removes a card from a hand *)
	val remove_from_hand : t -> hand -> hand

  (* shuffles a deck of cards *)
	val shuffle : deck -> deck
	val to_pair : t -> (Board.city * Board.city)
	val to_list : hand -> (Board.city * Board.city) list
end