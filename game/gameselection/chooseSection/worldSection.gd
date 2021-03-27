extends Control

onready var levelpopup = $levelpopup
onready var leveltitle = $levelpopup/TextureRect/levelTitle/Label
onready var section1label = $SectionButton1/Label
onready var section2label = $SectionButton2/Label
onready var section3label = $SectionButton3/Label
onready var level1label = $levelpopup/TextureRect/level1
onready var level2label = $levelpopup/TextureRect/level2
onready var level3label = $levelpopup/TextureRect/level3

var worlddetail = Global.pveworld
func _ready():
	if(worlddetail.has("sections")):
		if(0 <= worlddetail.sections.size()-1):
			section1label.text = worlddetail.sections[0].name
		if(1 <= worlddetail.sections.size()-1):
#			Global.pvesection = worlddetail.sections[1]
			section2label.text = worlddetail.sections[1].name
		if(2 <= worlddetail.sections.size()-1):
#			Global.pvesection = worlddetail.sections[2]
			section3label.text = worlddetail.sections[2].name
		pass # Replace with function body.

func _on_SectionButton_pressed(index):
	var sectiondetail = worlddetail.sections[index]
	
	if(sectiondetail.has("levels")):
		if(0 <= sectiondetail.levels.size()-1):
			level1label.text = sectiondetail.levels[0].name
			leveltitle.text = sectiondetail.levels[0].name
		if(1 <= sectiondetail.levels.size()-1):
			level2label.text = sectiondetail.levels[1].name
			leveltitle.text = sectiondetail.levels[1].name
		if(2 <= sectiondetail.levels.size()-1):
			level3label.text = sectiondetail.levels[2].name
			leveltitle.text = sectiondetail.levels[2].name
	
	Global.pvesection = sectiondetail
	levelpopup.popup()

func _on_Close_pressed():
	Global.pvesection = {}
	levelpopup.visible = false

func _on_level_pressed(level):

	Global.pvelvl = Global.pvesection.levels[level]
	print(level)
	print(Global.pvesection.levels[0])
	get_tree().change_scene("res://game/pve/"+ Global.worldmapper[Global.pveworld.name] +"/PVECombat.tscn")
	pass # Replace with function body.


