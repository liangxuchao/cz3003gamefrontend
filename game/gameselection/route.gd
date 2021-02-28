extends Control


func _on_redirectWorld_pressed():
	get_tree().change_scene("res://game/gameselection/chooseWorld/chooseWorld.tscn")

func _on_redirectCharacter_pressed():
	get_tree().change_scene("res://game/gameselection/chooseCharacter/chooseCharacter.tscn")

func _on_world1_pressed():
	get_tree().change_scene("res://game/gameselection/world1/world1Section.tscn")
	
func _on_world2_pressed():
	get_tree().change_scene('res://game/gameselection/world2/world2Section.tscn')
	
func _on_world3_pressed():
	get_tree().change_scene('res://game/gameselection/world3/world3Section.tscn')
	

func _on_world1Start_pressed():
		get_tree().change_scene('res://game/gameselection/world1/combat.tscn')
	

func _on_world2Start_pressed():
	get_tree().change_scene('res://game/gameselection/world2/combat.tscn')
	

func _on_world3Start_pressed():
	get_tree().change_scene('res://game/gameselection/world3/combat.tscn')
	

