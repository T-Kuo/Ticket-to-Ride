(* A [Card] has types and values for manipulating Ticket to Ride cards *)
module type Card = sig

  (* the type of a Ticket to Ride card *)
	type t
	(* the type of a hand *)
	type hand
	(* the type of a deck of cards *)
	type deck

  (* [new_deck] is a new deck of cards *)
	val new_deck : deck

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

end

(* A [Card] implementation that manipulates the train cards in Ticket to Ride *)
module TrainCard : sig
	include Card
end

(* A [Card] implementation that manipulates the ticket cards in Ticket to Ride *)
module TicketCard : sig
	include Card
end