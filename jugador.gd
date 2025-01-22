extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseMotion:
		mover(event.position)
	else:
		if (event.button_index == MOUSE_BUTTON_LEFT):
			print(position)
			print(event.position)
			estirar(event.position)
		
func estirar(pos):
	var x = pos.x
	var y = pos.y
	scale.x = 0.01 * (x - position.x)
	#scale.y = 0.0001 * (x - position.x)

func mover(pos):
	var x = pos.x
	var y = pos.y
	position.x = x
	position.y = y
