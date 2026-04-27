extends Node

var removed_from_poll = []
var len_x
var len_y

func _init(w, h):
	len_x = w; len_y = h
	for i in range(w * h): removed_from_poll.append(false)

func reset_removed_from_poll():
	for i in range(removed_from_poll.size()): removed_from_poll[i] = false

func remove_from_poll(arr):
	for a in arr: removed_from_poll[a] = true

func get_removed_from_poll_indexes():
	var arr = []
	for i in range(removed_from_poll.size()):
		if removed_from_poll[i]: arr.append(i)
	return arr

func get_candidate_matches_as_arrays(grilla, cmp):
	var todos = []
	# Filas
	for f in range(len_y):
		var fila = []
		for c in range(len_x):
			var idx = f * len_x + c
			if fila.size() > 0 and cmp.call(grilla[idx], grilla[fila[-1]]):
				fila.append(idx)
			else:
				if fila.size() >= 3: todos.append(fila.duplicate())
				fila = [idx]
		if fila.size() >= 3: todos.append(fila)
	# Columnas
	for c in range(len_x):
		var col = []
		for f in range(len_y):
			var idx = f * len_x + c
			if col.size() > 0 and cmp.call(grilla[idx], grilla[col[-1]]):
				col.append(idx)
			else:
				if col.size() >= 3: todos.append(col.duplicate())
				col = [idx]
		if col.size() >= 3: todos.append(col)
	return todos

func get_most_valuable_match(candidatos):
	candidatos.sort_custom(func(a, b): return a.size() > b.size())
	return {"type": 4, "indexes": candidatos[0]}
