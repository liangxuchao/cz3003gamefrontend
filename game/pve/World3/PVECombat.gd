extends Node2D
var win_scene = preload("res://game/pve/World3/Winner.tscn").instance()
var lose_scene = preload("res://game/pve/World3/LOSE.tscn").instance()
var animation = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sword/Sprite.frame=1
	animation = $Sword/AnimationPlayer



func _on_Answer1_pressed():
	$Sword/Sprite.frame=0
	animation.play("Move")
	$"Question BOX/Question".text="Q2: ABABABAB" # Show different text


func _win_pressed():
	get_tree().get_root().add_child(win_scene) # Replace with function body.



func _lose_pressed():
	get_tree().get_root().add_child(lose_scene) # Replace with function body.


func _on_Hit_Box_area_entered(area):
	$Sword/Sprite.frame=1 # Replace with function body.
