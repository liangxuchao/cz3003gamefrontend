extends Control

onready var levelpopup = $Popup
onready var leveltitle = $Popup/TextureRect/Label
onready var section1label = $SectionButton1/Label
onready var section2label = $SectionButton2/Label
onready var section3label = $SectionButton3/Label
onready var level1label = $Popup/TextureRect/level1/Label
onready var level2label = $Popup/TextureRect/level2/Label
onready var level3label = $Popup/TextureRect/level3/Label

var worlddetail = Global.pveworld
func _ready():
	if(worlddetail.has("sections")):
		if(0 <= worlddetail.sections.size()-1):
#			Global.pvesection = worlddetail.sections[0]
			section1label.text = worlddetail.sections[0].name
		if(1 <= worlddetail.sections.size()-1):
#			Global.pvesection = worlddetail.sections[1]
			section2label.text = worlddetail.sections[1].name
		if(2 <= worlddetail.sections.size()-1):
#			Global.pvesection = worlddetail.sections[2]
			section3label.text = worlddetail.sections[2].name
		pass # Replace with function body.


func _on_SectionButton_pressed(index):
	var sectiondetail = Global.pveworld[index]
	if(sectiondetail.has("levels")):
		if(0 <= sectiondetail.levels.size()-1):
			level1label.text = sectiondetail.levels[0].name
		if(1 <= sectiondetail.levels.size()-1):
			level2label.text = sectiondetail.levels[1].name
		if(2 <= sectiondetail.levels.size()-1):
			level3label.text = sectiondetail.levels[2].name
	leveltitle.text = sectiondetail.name
	levelpopup.popup()


func _on_Close_pressed():
	levelpopup.visible = false


func _on_level_pressed(level):
	Global.pvelvlselection = level
	get_tree().change_scene("res://game/pve/World1/PVECombat.tscn")
	pass # Replace with function body.


