extends Control
var win_scene = preload("res://game/pve/World3/Winner.tscn").instance()
var lose_scene = preload("res://game/pve/World3/LOSE.tscn").instance()
var plarAnimation = null
var bossAnimation = null

onready var boss = $VBoxContainer


onready var menupopup = $Popup
var currentlvl;
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var scence = load("res://game/interface/boss/" + Global.worldmapper[Global.pveworld.name] +"/section1"  + ".tscn").instance()
	boss.add_child(scence) # Replace with function body.

	#api call
	
	#end 
	$Sword/Sprite.texture = preload("res://public/image/world2/IMG_0414-removebg-preview.png");
	$Sword/Sprite.frame=1
	$BossAttack/Sprite.frame=1
	plarAnimation = $Sword/AnimationPlayer
	bossAnimation=$BossAttack/AnimationPlayer
	

func _on_MenuButton_pressed():
	menupopup.popup()
	pass # Replace with function body.


func _on_Answer1_pressed():
	$Sword/Sprite.frame=0
	plarAnimation.play("Move")
	$"Question BOX/Question".text="Q2: ABABABAB" # Show different text


func _win_pressed():
	get_tree().get_root().add_child(win_scene) # Replace with function body.



func _lose_pressed():
	get_tree().get_root().add_child(lose_scene) # Replace with function body.


func _on_Hit_Box_area_entered(area):
	$Sword/Sprite.frame=1 # Replace with function body.


func _on_CloseButton_pressed():
	menupopup.visible = false;
	pass # Replace with function body.


func _on_quit_pressed():
	
	get_tree().change_scene('res://game/gameselection/world3/world3Section.tscn')
	pass # Replace with function body.


func _on_retry_pressed():
	
	pass # Replace with function body.

func _on_Answer2_pressed():
	$BossAttack/Sprite.frame=0
	bossAnimation.play("Boss Attack")
	$"Question BOX/Question".text="Q2: ABABABAB" 
	



func _on_Hit_Box_playArea_entered(area):
	$BossAttack/Sprite.frame=1
	
