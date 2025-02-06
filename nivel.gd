extends Node2D

@onready var game_over = get_node("/root/Nivel/GameOverBackground")
@onready var game_over_label = get_node("/root/Nivel/GameOverBackground/Label")
@onready var jugador = $Burbuja
@onready var root = get_tree().root
@onready var burbuja_area = $BurbujaArea
@onready var barra_oxigeno = get_node('/root/Nivel/BarraOxigeno')
@onready var win = get_node("/root/Nivel/WinBackground")
@onready var win_label = get_node("/root/Nivel/WinBackground/Label")
@onready var enemigoAtacante1 = get_node('EnemigoAtacante1')


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over.visible = false
	win.visible = false
	jugador.connect("player_died", Callable(self, "on_player_died"))
	jugador.connect("player_win", Callable(self, "on_player_win"))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if barra_oxigeno.GetValue() == 0:
		game_over.visible = true

func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_R) or (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT):
		reiniciarJuego()
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_M:
			toogleBackground()
var sonido = false

func reiniciarJuego():
	enemigoAtacante1.reiniciar()
	game_over.visible = false
	win.visible = false
	barra_oxigeno.reiniciar()
	jugador.reiniciar()

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

func on_player_died() -> void:
	game_over.visible = true
	#get_tree().paused = true
	enemigoAtacante1.frenar()
	pause_all_nodes()

func on_player_win() -> void:
	win.visible = true
	#get_tree().paused = true
	enemigoAtacante1.frenar()
	jugador.ganar()
	pause_all_nodes()

func pause_all_nodes():
	for child in root.get_children():
		child.set_process(false)

func _on_button_pressed() -> void:
	reiniciarJuego()
