extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_M:
			toogleBackground()
var sonido = false

func toogleBackground() -> void:
	if sonido:
		pararSonido()
		sonido = false
	else:
		reproducir()
		sonido = true

func reproducir() -> void:
	$AudioStreamPlayer.play()

func pararSonido() -> void:
	$AudioStreamPlayer.stop()
