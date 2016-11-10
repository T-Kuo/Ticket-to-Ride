(* A [Card] has types and values for manipulating Ticket to Ride cards *)
module type Card = sig

  (* the type of a Ticket to Ride card *)
	type t
	(* the type of a hand *)
	type t hand
	(* the type of a deck of cards *)
	type t deck

  (* [new_deck] is a new deck of cards *)
	val new_deck : t deck

  (* draws a card from a deck *)
	val draw : t deck ->  t

  (* adds a card to a hand *)
	val add_to_hand : t -> t hand -> t hand

  (* removes a card from a hand *)
	val remove_from_hand : t -> t hand -> t hand

  (* checks if a deck of cards is empty *)
	val is_empty : t deck -> bool

  (* shuffles a deck of cards *)
	val shuffle : t deck -> t deck

  (* discards a card *)
	val discard : t -> t deck -> t deck

end

(* A [Card] implementation that manipulates the train cards in Ticket to Ride *)
module TrainCard : Card

(* A [Card] implementation that manipulates the ticket cards in Ticket to Ride *)
module TicketCard : Card