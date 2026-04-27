extends ProgressBar

signal reached_zero

func change_value_to(new_value):
	value = new_value
	
func add_value(amount):
	value += amount
	
func _physics_process(delta):
	value -= 15 * delta

func _on_value_changed(v):
	if v <= 1:
		reached_zero.emit()
