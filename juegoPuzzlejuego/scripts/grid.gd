extends Node2D

const SPRITE_SIZE = 32
const Match3Core = preload("res://scripts/standalone/match3_core.gd")
const FichaPrefab = preload("res://scenes/piece.tscn")

@export var grid_size_x = 6
@export var grid_size_y = 8
@export var spacement = 0

var pieces_resources = [
	preload("res://resources/bat.tres"),
	preload("res://resources/candle.tres"),
	preload("res://resources/ghost.tres"),
	preload("res://resources/hat.tres"),
	preload("res://resources/pumpkin.tres")
]

var multipliers = [10, 20, 30, 40, 50] 
var dificultad = 0
var bloqueado = false
var requiere_update = true
var combo = 0
var fichas = []
var logica

var ficha_seleccionada = null
var pos_inicial_mouse = Vector2.ZERO

func _ready():
	Events.current_score = 0
	Events.swap_requested.connect(on_swap_requested)
	Events.shuffle_requested.connect(on_shuffle_requested)
	
	for i in range(grid_size_x * grid_size_y):
		fichas.append(null)
		
	logica = Match3Core.new(grid_size_x, grid_size_y)
	await get_tree().create_timer(0.5).timeout
	try_next_match()

func _input(event):
	if bloqueado: return
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			pos_inicial_mouse = get_local_mouse_position()
			ficha_seleccionada = obtener_ficha(pos_inicial_mouse)
		else:
			if ficha_seleccionada != null:
				var pos_final = get_local_mouse_position()
				var dif = pos_final - pos_inicial_mouse
				
				if dif.length() > 10: 
					deslizar_ficha(ficha_seleccionada, dif)
				
				ficha_seleccionada = null

func obtener_ficha(pos):
	var tamano_celda = SPRITE_SIZE + spacement
	if pos.x < -10 or pos.y < -10: return null
	
	var col = int(max(0, pos.x) / tamano_celda)
	var fila = int(max(0, pos.y) / tamano_celda)
	
	if col >= 0 and col < grid_size_x and fila >= 0 and fila < grid_size_y:
		return fichas[fila * grid_size_x + col]
	return null

func deslizar_ficha(ficha, dif):
	var col = ficha.index % grid_size_x
	var fila = int(ficha.index / grid_size_x)
	if abs(dif.x) > abs(dif.y):
		if dif.x > 0: col += 1 
		else: col -= 1 
	else:
		if dif.y > 0: fila += 1 
		else: fila -= 1 
	if col >= 0 and col < grid_size_x and fila >= 0 and fila < grid_size_y:
		var destino = fichas[fila * grid_size_x + col]
		if destino != null: on_swap_requested(ficha, destino)

func swap_pieces(a, b):
	var old_a = a.index
	var old_b = b.index
	fichas[old_a] = b
	fichas[old_b] = a
	a.index = old_b
	b.index = old_a
	a.actualizar_posicion(grid_size_x, spacement, SPRITE_SIZE)
	b.actualizar_posicion(grid_size_x, spacement, SPRITE_SIZE)
	await get_tree().create_timer(0.2).timeout

func on_swap_requested(a, b):
	if bloqueado: return
	lock_actions()
	await swap_pieces(a, b)
	var candidatos = logica.get_candidate_matches_as_arrays(fichas, cmp_func)
	if candidatos.is_empty(): await swap_pieces(a, b)
	unlock_actions()
	try_next_match()

func lock_actions(): bloqueado = true; Events.input_locket = true
func unlock_actions(): bloqueado = false; Events.input_locket = false

func fill_dispenser():
	var lleno = false
	for i in range(grid_size_x):
		if fichas[i] == null:
			var nueva = FichaPrefab.instantiate()
			nueva.init(pieces_resources[randi() % pieces_resources.size()], grid_size_x)
			add_child(nueva)
			fichas[i] = nueva
			nueva.index = i
			nueva.actualizar_posicion(grid_size_x, spacement, SPRITE_SIZE)
			lleno = true
	return lleno

func bajar_fichas():
	var movio = false
	for i in range(grid_size_x * (grid_size_y - 1) - 1, -1, -1):
		var abajo = i + grid_size_x
		if abajo < grid_size_x * grid_size_y and fichas[abajo] == null and fichas[i] != null:
			fichas[abajo] = fichas[i]
			fichas[i] = null
			fichas[abajo].index = abajo
			fichas[abajo].actualizar_posicion(grid_size_x, spacement, SPRITE_SIZE)
			movio = true
	return movio

func try_next_match():
	if bloqueado: return
	lock_actions()
	requiere_update = true
	while requiere_update:
		while fill_dispenser() or bajar_fichas():
			await get_tree().create_timer(0.05).timeout
		
		logica.reset_removed_from_poll()
		var candidatos = logica.get_candidate_matches_as_arrays(fichas, cmp_func)
		if candidatos.is_empty(): requiere_update = false
		else:
			var mejor = logica.get_most_valuable_match(candidatos)
			logica.remove_from_poll(mejor.indexes)
			for idx in mejor.indexes:
				if fichas[idx]:
					fichas[idx].on_score(1)
					fichas[idx].queue_free()
					fichas[idx] = null
			await get_tree().create_timer(0.2).timeout
	unlock_actions()

func cmp_func(a, b):
	if not a or not b: return false
	return a._piece_res.type == b._piece_res.type

func on_shuffle_requested(): pass
func son_vecinos(a, b): return abs(a-b) == 1 or abs(a-b) == grid_size_x
