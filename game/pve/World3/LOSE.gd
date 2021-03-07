extends Control

func _ready():
	pass # Replace with function body.


func _on_Try_Again_pressed():
	get_tree().change_scene("res://game/pvp/World3/PVP Room.tscn")

func _on_Back_pressed():
	get_tree().change_scene("res://game/gameselection/world3/world3Section.tscn")# Replace with function body.
