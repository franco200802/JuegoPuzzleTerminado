extends Node

signal new_match_found(m)
signal piece_index_changed(piece: Piece)
signal piece_removed_from_poll(index: int)
signal swap_requested(a, b)
signal piece_scored(pontuation: int)
signal combo_started()
signal combo_changed(value)
signal combo_ended(amount)
signal medium_dificulty_reached
signal hard_dificulty_reached
signal shuffle_requested
signal game_over(score)

var current_level = 1
var current_score: int = 0
var input_locket = false
