extends ProgressBar

var maxValor: int = 100
var disminucionOxigeno: int = 5
var tiempoTranscurrido: float = 0.0

func _ready() -> void:
	
	max_value = maxValor
	value = maxValor
	
func _process(delta: float) -> void:
	
	tiempoTranscurrido += delta
	
	if tiempoTranscurrido >= 1.0:
		DisminuirOxigeno()
		tiempoTranscurrido = 0.0
	
func DisminuirOxigeno():
	
	if value > 0:
		value -= disminucionOxigeno
		value = max(value, 0)
		actualiza_color(value)
		
	else:
		pass

func actualiza_color(value):
	
	var color: Color
	var fill_style = get_theme_stylebox("fill", "ProgressBar")
	
	if fill_style and fill_style is StyleBoxFlat:
	
		if value > 60:
			color = Color(0,0.35,0)
		elif value > 25:
			color = Color(1, 1, 0)
		else:
			color = Color(1, 0, 0)
		
		fill_style.bg_color = color
