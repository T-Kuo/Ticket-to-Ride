type action = 
| DrawFaceUp of int
| DrawDeck
| ClaimRoute of (Card.TrainCard.t list)
| RequestTickets