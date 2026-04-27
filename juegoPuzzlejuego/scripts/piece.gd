extends Node2D
class_name Piece

@export var _piece_res: Resource 
@onready var label_index = $Debug_index
@onready var texture_rect = $TextureRect

var _interactable = true
var _grid_size_x = 0
var next_index = -1
var used = false

var index = -1:
	set(value):
		index = value
		if label_index: label_index.text = str(index)
		Events.piece_index_changed.emit(self)
		name = "piece_" + str(value)
		_interactable = index >= _grid_size_x

func init(res, w):
	_piece_res = res
	_grid_size_x = w
	z_index = 10 

func _ready():
	if _piece_res and texture_rect:
		texture_rect.texture = _piece_res.sprite
		texture_rect.custom_minimum_size = Vector2(32, 32)
		texture_rect.size = Vector2(32, 32)

func on_score(multi):
	var puntos = _piece_res.points * multi
	Events.piece_scored.emit(int(puntos))
	return puntos

func actualizar_posicion(ancho, espaciado, tamano):
	var col = index % ancho
	var fila = int(index / ancho)
	position = Vector2(col * (tamano + espaciado), fila * (tamano + espaciado))
