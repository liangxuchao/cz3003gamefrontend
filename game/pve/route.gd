extends Control


func _on_backto_select_world_pressed():
	get_tree().change_scene("res://game/pve/chooseWorld/chooseWorld.tscn")

func _on_backto_title_pressed():
	get_tree().change_scene("res://game/pve/chooseWorld/chooseWorld.tscn")

func _on_world1_pressed():
	get_tree().change_scene("res://game/pve/world1/world1Section.tscn")
	
func _on_world2_pressed():
	get_tree().change_scene('res://game/pve/world1/world2Section.tscn')
	
func _on_world3_pressed():
	get_tree().change_scene('res://game/pve/world1/world3Section.tscn')
	
