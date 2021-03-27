extends Control
var win_scene = preload("res://game/pve/World3/Winner.tscn").instance()
var lose_scene = preload("res://game/pve/World3/LOSE.tscn").instance()
var plarAnimation = null
var bossAnimation = null
var boss =null


var menu_scene = preload("res://game/pve/World3/Menu.tscn").instance()
var currentlvl;
# Called when the node enters the scene tree for the first time.
func _ready():
	currentlvl = Global.pvelvlselection;
	boss = Global.pvebossselection;
	if boss == 31 :
		$Boss1.texture = preload("res://.import/boss1.png-14b1a06b9eb8c50a1d693d016094455e.stex");
		$BossAttack/Sprite.texture = preload("res://public/image/world3/Bone Weapon.png");
	elif boss == 32:
		 $Boss1.texture = preload("res://.import/boss2.png-7698100e92789fa74544eb4d12ec6649.stex");
		 $BossAttack/Sprite.texture = preload("res://public/image/world3/stone attack.png");
	else:
		 $Boss1.texture = preload("res://.import/boss3.png-6335d50488a5f84548acfc72a8a7c1a5.stex");
		 $BossAttack/Sprite.texture = preload("res://public/image/world3/blade of death.png");
	#api call
	
	#end 
	$Sword/Sprite.texture = preload("res://public/image/world2/IMG_0414-removebg-preview.png");
	$Sword/Sprite.frame=1
	$BossAttack/Sprite.frame=1
	plarAnimation = $Sword/AnimationPlayer
	bossAnimation=$BossAttack/AnimationPlayer
	

func _on_MenuButton_pressed():
	get_tree().get_root().add_child(menu_scene)
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


func _on_Answer2_pressed():
	$BossAttack/Sprite.frame=0
	bossAnimation.play("Boss Attack")
	$"Question BOX/Question".text="Q2: ABABABAB" 
	



func _on_Hit_Box_playArea_entered(area):
	$BossAttack/Sprite.frame=1
	
