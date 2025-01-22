extends Sprite2D

var burbuja = preload('res://burbujaEstirar.gd').new()
const ESTADOS: Dictionary = {'estado1': 'posicion_burbuja_para_editar_PNG.webp', 'estado2': 'posicion_burbuja_normal_PNG.webp', 'estado3': 'posicion_burbuja_estirada_PNG.webp'}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseMotion:
		mover(event.position)
	if Input.is_key_pressed(KEY_1):
		self.texture = burbuja.cargarSprite(ESTADOS.estado1)
	if Input.is_key_pressed(KEY_2):
		self.texture = burbuja.cargarSprite(ESTADOS.estado2)
	if Input.is_key_pressed(KEY_3):
		self.texture = burbuja.cargarSprite(ESTADOS.estado3)
	
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
