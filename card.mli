module type Card = sig

	type t
	type t hand
	type t deck


	val new_deck : t deck

	val draw : t deck ->  t

	val add_to_hand : t -> t hand -> t hand

	val remove_from_hand : t -> t hand -> t hand

	val is_empty : t deck -> bool

	val shuffle : t deck -> t deck

	val discard : t -> t deck -> t deck

end


module TrainCard : Card

module TicketCard : Card