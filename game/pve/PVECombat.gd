extends Control
var win_scene = preload("res://game/pve/World2/Winner.tscn").instance()
var lose_scene = preload("res://game/pve/World2/LOSE.tscn").instance()
var animation = null

onready var httpNode = $HTTPRequest

onready var boss = $boss
onready var character = $character
onready var menupopup = $Popup

var questions
# Called when the node enters the scene tree for the first time.
func _ready():
	#api call
	var authheader: PoolStringArray = ['Authorization: Bearer ' + Global.AccessToken ] 
	
	httpNode.connect("request_completed", self, "_on_request_completed_questionlist")
	httpNode.request(Global.APIrooturl +  "/api/v1/user/question/" + str(Global.pvelvl.id),authheader,false,HTTPClient.METHOD_GET)
	#end 
	print(Global.pvesection)
	#var bossscence = load("res://game/interface/boss/" + Global.worldmapper[Global.pveworld.name] +"/section7.tscn").instance()
	
	var bossscence = load("res://game/interface/boss/" + Global.worldmapper[Global.pveworld.name] +"/section" + str(Global.pvesection.id)  + ".tscn").instance()
	boss.add_child(bossscence) # Replace with function body.
	
	var charascence = load("res://game/interface/character/character" + str(Global.character) + ".tscn").instance()
	character.add_child(charascence) # Replace with function body.
	
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



func _on_request_completed_questionlist(result, response_code,headers, body):	
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	if response_code == 200:
		questions = json.result
	
