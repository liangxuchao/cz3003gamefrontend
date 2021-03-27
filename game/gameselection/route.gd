extends Control


func _on_redirectWorld_pressed():
	get_tree().change_scene("res://game/gameselection/chooseWorld/chooseWorld.tscn")

func _on_redirectCharacter_pressed():
	get_tree().change_scene("res://game/gameselection/chooseCharacter/chooseCharacter.tscn")


func _on_world_pressed(title):
	print(title)
	for key in Global.WorldsDetails.size():
		if Global.WorldsDetails[key].name == title:
			Global.pveworld = Global.WorldsDetails[key]
		else:
			Global.pveworld = {}
	if title == "Taming the Python":
		get_tree().change_scene("res://game/gameselection/chooseSection/world1Section.tscn")
	elif title == "php":
		get_tree().change_scene("res://game/gameselection/chooseSection/world2Section.tscn")
	elif title == "Surfing on Java":
		get_tree().change_scene("res://game/gameselection/chooseSection/world3Section.tscn")
	pass # Replace with function body.
	
		
	
func _on_world1Start_pressed():
		get_tree().change_scene('res://game/gameselection/world1/combat.tscn')
	

func _on_world2Start_pressed():
	get_tree().change_scene('res://game/gameselection/world2/combat.tscn')
	

func _on_world3Start_pressed():
	get_tree().change_scene('res://game/gameselection/world3/combat.tscn')
	

