extends Control

onready var levelpopup = $Popup
onready var leveltitle = $Popup/TextureRect/Label

func _ready():
	pass # Replace with function body.

func _on_SectionButton_pressed(sectiontitle):
	#api call
	leveltitle.text = sectiontitle
	levelpopup.popup()

func _on_CloseButton_pressed():
	levelpopup.visible = false


func _on_level_pressed(level):
	#Global.pvelvlselection = level
	#get_tree().change_scene("res://game/pve/World2/PVECombat.tscn")
	pass # Replace with function body.


func _on_SectionButton1_pressed(sectiontitle):
	leveltitle.text = sectiontitle
	levelpopup.popup()
