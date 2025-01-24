extends AnimatedSprite2D

@export var velocidad = 200 # Velocidad de movimiento
@onready var area_de_vision = $ConoDeVision

var objetivo = null # Variable para almacenar el objetivo detectado

func _ready():
	add_to_group("enemigos") # Asegurate de que el enemigo esté en el grupo "enemigos"
	#area_de_vision.connect("body_entered", Callable(self, "_on_body_entered"))
	#area_de_vision.connect("body_exited", Callable(self, "_on_body_exited"))

func _process(delta):
	if objetivo != null:
		# Calcula la dirección hacia el objetivo
		var direccion = (objetivo.global_position - global_position).normalized()
		# Mueve personaje hacia el objetivo
		position += direccion * velocidad * delta
		#Rota el Sprite para que mire al objetivo
		rotation = direccion.angle()

func _on_body_entered(body):
	# Verifica si el cuerpo que entró en el área es el objetivo
	print(body)
	if body.is_in_group("objetivo"):
		objetivo = body

func _on_body_exited(body):
	# Si el objetivo sale del área de visión, lo establece como nulo
	if body == objetivo:
		objetivo = null
