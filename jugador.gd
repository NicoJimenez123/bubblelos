extends Sprite2D

@export var move_speed : float = 10.0
@export var rotation_speed : float = 10.0

var burbuja = preload('res://burbujaEstirar.gd').new()
const ESTADOS: Dictionary = {
	'estado1': 'posicion_burbuja_para_editar_PNG.webp',
	'estado2': 'posicion_burbuja_normal_PNG.webp',
	'estado3': 'posicion_burbuja_estirada_PNG.webp',
	'estado4': 'posicion_burbuja_por_reventar_PNG.webp',
	'estado5': 'posicion_burbuja_rota_PNG.webp',
}

# Define los rangos de distancia y los estados asociados
const DISTANCE_RANGES: Array[Dictionary] = [
	{ "max_distance": 100, "state": "estado1" },
	{ "max_distance": 400, "state": "estado2" },
	{ "max_distance": 500, "state": "estado3" },
	{ "max_distance": 700, "state": "estado4" },
	{ "max_distance": 100000000000, "state": "estado5" }, #Valor máximo, el último sprite.
]

var current_state: String = "estado1" #CAMBIADO A ESTADO 1

var clickeando = false
var click_start_position = Vector2()
var current_impulse = Vector2()
var current_velocity = Vector2()
var bubble_start_position = Vector2() #Posición inicial de la burbuja.
var last_rotation : float = 0.0 #Variable para guardar la rotación.

@onready var burbuja_area = $BurbujaArea

func _ready() -> void:
	burbuja_area.connect("area_entered", Callable(self, "_on_burbuja_area_entered"))
	#Fijamos la escala por defecto.
	scale = Vector2(1,1)
	pass

func _physics_process(delta: float) -> void:
	# Aplica el impulso a la posición de la burbuja
	position += current_velocity * delta
	
	# Obtener el ángulo de rotación desde el vector de velocidad
	var target_angle = current_velocity.angle()
	
	#Aplicamos un offset para que la rotación sea correcta.
	var offset_angle = PI/2
	
	#Interpolamos el ángulo
	rotation = lerp(last_rotation, target_angle + offset_angle, rotation_speed * delta)
	
	current_velocity = current_velocity * 0.9
	var distance = (position - bubble_start_position).length()
	if abs(current_velocity.x) < 0.1 and abs(current_velocity.y) < 0.1: # Si la velocidad es menor a 0.1
		current_velocity = Vector2.ZERO #Detenemos la burbuja
		bubble_start_position = position
		last_rotation = rotation #Guardamos la rotación cuando se detiene.
	#Calculamos el estado del sprite segun la distancia recorrida.
	var new_state = get_state_for_distance(distance)
	#CAMBIO IMPORTANTE: ASIGNAMOS LA TEXTURA AL SPRITE
	self.texture = burbuja.cargarSprite(ESTADOS[new_state])

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
			
			 #Calculamos el ángulo inicial para que la burbuja "apunte" al ratón.
			var initial_angle = impulse_vector.angle() + PI/2;
			
			last_rotation = initial_angle; #Inicializamos el valor de la variable.
			rotation = last_rotation; # Inicializamos la rotación con el último valor de rotación
			
			current_velocity = impulse_vector * move_speed
		
func get_state_for_distance(distance: float) -> String:
	for range in DISTANCE_RANGES:
		if distance <= range.max_distance:
			return range.state
	return "estado5"  # Por si algo falla, aplicamos el último estado

func _on_enemigo_area_area_entered(area: Area2D) -> void:
	self.texture = burbuja.cargarSprite(ESTADOS['estado5'])
	await get_tree().create_timer(0.2).timeout
	queue_free()  # Eliminar la burbuja
