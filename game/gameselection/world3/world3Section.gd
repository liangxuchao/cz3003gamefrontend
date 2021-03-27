extends Control


onready var levelpopup = $levelpopup
onready var leveltitle = $levelpopup/TextureRect/levelTitle/Title


func _ready():
	pass # Replace with function body.


func _on_SectionButton_pressed(sectiontitle, boss):
	#api call
	leveltitle.text = sectiontitle
	Global.pvebossselection=boss
	levelpopup.popup()



func _on_CloseButton_pressed():
	levelpopup.visible = false


func _on_level_pressed(level):
	Global.pvelvlselection = level
	get_tree().change_scene("res://game/pve/World3/PVECombat.tscn")
	pass # Replace with function body.
