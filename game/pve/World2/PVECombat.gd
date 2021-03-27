extends Control
var win_scene = preload("res://game/pve/World2/Winner.tscn").instance()
var lose_scene = preload("res://game/pve/World2/LOSE.tscn").instance()
var animation = null


onready var boss = $VBoxContainer
onready var menupopup = $Popup
var currentlvl;
var currentsection;
# Called when the node enters the scene tree for the first time.
func _ready():
	currentlvl = Global.pvelvl;
	currentsection = Global.pvesection;
	#api call
	
	#end 
	var scence = load("res://game/interface/boss/world2/section" + currentsection + ".tscn").instance()
	boss.add_child(scence) # Replace with function body.


	$Sword/Sprite.frame=1
	animation = $Sword/AnimationPlayer

func _on_MenuButton_pressed():
	menupopup.popup()
	pass # Replace with function body.


func _on_Answer1_pressed():
	$Sword/Sprite.frame=0
	animation.play("Move")
	$"Question BOX/Question".text="Q2: ABABABAB" # Show different text


func _win_pressed():
	get_tree().get_root().add_child(win_scene) # Replace with function body.



func _lose_pressed():
	get_tree().get_root().add_child(lose_scene) # Replace with function body.


func _on_Hit_Box_area_entered(area):
	print("1233")
	$Sword/Sprite.frame=1 # Replace with function body.


func _on_CloseButton_pressed():
	menupopup.visible =false
	pass # Replace with function body.


func _on_quit_pressed():
	
	get_tree().change_scene('res://game/gameselection/world2/world2Section.tscn')
	pass # Replace with function body.


func _on_retry_pressed():
	
	pass # Replace with function body.
