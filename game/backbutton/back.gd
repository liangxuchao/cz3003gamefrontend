extends Button


export(String) var scene_to_load

func _on_backbutton_pressed():
	get_tree().change_scene(scene_to_load)
	
