extends Node2D

@onready var game_over = get_node("/root/Nivel/GameOverBackground")
@onready var game_over_label = get_node("/root/Nivel/GameOverBackground/Label")
@onready var jugador = $Burbuja
@onready var root = get_tree().root
@onready var burbuja_area = $BurbujaArea
@onready var barra_oxigeno = get_node('/root/Nivel/BarraOxigeno')
@onready var win = get_node("/root/Nivel/WinBackground")
@onready var win_label = get_node("/root/Nivel/WinBackground/Label")

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
	if Input.is_key_pressed(KEY_R):
		game_over.visible = false
		win.visible = false
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

func on_player_died() -> void:
	game_over.visible = true
	#get_tree().paused = true
	pause_all_nodes()
	print("Game Over")

func on_player_win() -> void:
	print("Win")
	win.visible = true
	#get_tree().paused = true
	pause_all_nodes()
	print("Win")

func pause_all_nodes():
	for child in root.get_children():
		child.set_process(false)
