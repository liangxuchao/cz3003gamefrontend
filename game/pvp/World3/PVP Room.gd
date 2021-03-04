extends Node2D
var win_scene = preload("res://game/pvp/World3/Winner.tscn").instance()
var lose_scene = preload("res://game/pvp/World3/LOSE.tscn").instance()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Answer1_pressed():
	$"Question BOX/Question".text="Q2: ABABABAB" # Show different text


func _win_pressed():
	get_tree().get_root().add_child(win_scene) # Replace with function body.



func _lose_pressed():
	get_tree().get_root().add_child(lose_scene) # Replace with function body.
