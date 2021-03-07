extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Button_pressed():
	get_tree().change_scene("res://game/pve/World3/PVECombat.tscn")
	pass # Replace with function body.


func _on_CloseButton_pressed():
	get_tree().change_scene("res://game/gameselection/world3/world3Section.tscn") 
