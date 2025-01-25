extends VideoStreamPlayer

func _ready():
	# Assuming the function you want to connect to is named "_on_VideoStreamPlayer_finished"
	#connect("finished", self, "_on_VideoStreamPlayer_finished")  # This line is corrected
	pass
	
func _on_VideoStreamPlayer_finished():
	queue_free()
	get_tree().change_scene_to_file("res://icon.tscn")
	return self

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		queue_free()
		get_tree().change_scene_to_file("res://icon.tscn")
