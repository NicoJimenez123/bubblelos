extends VideoStreamPlayer

func _ready():
	# Assuming the function you want to connect to is named "_on_VideoStreamPlayer_finished"
	pass

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		get_tree().change_scene_to_file("res://icon.tscn")
		queue_free()


func _on_finished() -> void:
	get_tree().change_scene_to_file("res://icon.tscn")
	queue_free()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://icon.tscn")
	queue_free()
