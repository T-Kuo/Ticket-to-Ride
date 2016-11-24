open OUnit2
open Board
open Color
open Player



let tests = [

"basic" >:: (fun _ -> assert_equal
	(4,[ab])
		(shortest_path Player1 a b new_board));

"alternate" >:: (fun _ -> assert_equal
	(7,[ac])
		(shortest_path Player1 a c new_board));

"longer" >:: (fun _ -> assert_equal
	(9,[cd;ac])
		(shortest_path Player1 a d new_board));

"has_connected1" >:: (fun _ -> assert_equal false
  (has_connected Player1 a b new_board));

"claim_route1" >:: (fun _ -> assert_equal true
  (claim_route Player1 ab new_board |> fst));

"has_connected2" >:: (fun _ -> assert_equal true
  (claim_route Player1 ab new_board |> snd |> has_connected Player1 a b));

"claim_route2" >:: (fun _ -> assert_equal false
  (claim_route Player1 ab new_board |> snd |> claim_route Player2 ab |> fst));

]