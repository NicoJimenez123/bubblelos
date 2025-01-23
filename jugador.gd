extends Sprite2D

var burbuja = preload('res://burbujaEstirar.gd').new()
const ESTADOS: Dictionary = {'estado1': 'posicion_burbuja_para_editar_PNG.webp',
	'estado2': 'posicion_burbuja_normal_PNG.webp',
	'estado3': 'posicion_burbuja_estirada_PNG.webp',
	'estado4': 'posicion_burbuja_por_reventar_PNG.webp',
	'estado5': 'posicion_burbuja_rota_PNG.webp',
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var clickeando = false
var clickStartX = 0
var clickStartY = 0
var clickEndX = 0
var clickEndY = 0

func _input(event):
	if Input.is_key_pressed(KEY_R):
		position.x = 160
		position.y = 160
	if event is InputEventMouseMotion:
		#print(event)
		#mover(event.position)
		pass
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			clickeando = true
			# Guardar posición desde donde se clickeó
			clickStartX = event.position.x
			clickStartY = event.position.y
			var resultado = (get_process_delta_time() + 1) * (clickStartX + clickStartY)
		if event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
			clickeando = false
			clickEndX = event.position.x
			clickEndY = event.position.y
		if !clickeando:
			mover({'x': (clickEndX - clickStartX), 'y': (clickEndY - clickStartY)})
	if clickeando && event is InputEventMouseMotion:
		pass
		
	if Input.is_key_pressed(KEY_1):
		self.texture = burbuja.cargarSprite(ESTADOS.estado1)
	if Input.is_key_pressed(KEY_2):
		self.texture = burbuja.cargarSprite(ESTADOS.estado2)
	if Input.is_key_pressed(KEY_3):
		self.texture = burbuja.cargarSprite(ESTADOS.estado3)
	if Input.is_key_pressed(KEY_4):
		self.texture = burbuja.cargarSprite(ESTADOS.estado4)
	if Input.is_key_pressed(KEY_5):
		self.texture = burbuja.cargarSprite(ESTADOS.estado5)
	
func estirar(pos):
	var x = pos.x
	var y = pos.y
	scale.x = 0.01 * (x - position.x)
	#scale.y = 0.0001 * (x - position.x)

func mover(pos):
	var x = pos.x
	var y = pos.y
	position.x += x
	position.y += y
