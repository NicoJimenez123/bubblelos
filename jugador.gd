extends Sprite2D

@export var move_speed : float = 10.0

var burbuja = preload('res://burbujaEstirar.gd').new()
const ESTADOS: Dictionary = {
	'estado1': 'posicion_burbuja_para_editar_PNG.webp',
	'estado2': 'posicion_burbuja_normal_PNG.webp',
	'estado3': 'posicion_burbuja_estirada_PNG.webp',
	'estado4': 'posicion_burbuja_por_reventar_PNG.webp',
	'estado5': 'posicion_burbuja_rota_PNG.webp',
}

var clickeando = false
var click_start_position = Vector2()
var current_impulse = Vector2()
var current_velocity = Vector2()

func _ready() -> void:
	#Fijamos la escala por defecto.
	scale = Vector2(1,1)
	pass

func _physics_process(delta: float) -> void:
	# Aplica el impulso a la posición de la burbuja
	position += current_velocity * delta
	current_velocity = current_velocity * 0.9
	if abs(current_velocity.x) < 0.1 and abs(current_velocity.y) < 0.1: # Si la velocidad es menor a 0.1
		current_velocity = Vector2.ZERO #Detenemos la burbuja


func _input(event):
	if Input.is_key_pressed(KEY_R):
		position.x = 160
		position.y = 160
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			# Se presiona el click, guardamos la posición
			clickeando = true
			click_start_position = get_global_mouse_position()
		if !event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			# Se suelta el click, calculamos y aplicamos el impulso
			clickeando = false
			var current_mouse_position = get_global_mouse_position()
			var impulse_vector = current_mouse_position - click_start_position
			current_velocity = impulse_vector * move_speed
