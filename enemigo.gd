extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("enemigos")  # Asegúrate de que el enemigo esté en el grupo "enemigos"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
