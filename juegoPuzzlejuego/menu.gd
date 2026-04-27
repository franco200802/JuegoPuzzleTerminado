extends Control

@onready var btn_nivel_2 = $BotonNivel2

func _ready():
	if Progreso.nivel_2_desbloqueado == false:
		btn_nivel_2.disabled = true
		btn_nivel_2.modulate = Color(0.5, 0.5, 0.5)
	else:
		btn_nivel_2.disabled = false
		btn_nivel_2.modulate = Color(1, 1, 1)

func _on_boton_nivel_1_pressed():
	get_tree().change_scene_to_file("res://scenes/puzzle_escena.tscn")

func _on_boton_nivel_2_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
