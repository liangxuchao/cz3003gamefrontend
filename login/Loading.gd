extends Control

onready var httpNode = $HTTPRequest

onready var labelnode = $Label
onready var animation = $Label/AnimationPlayer

func _ready():
	animation.play("loading")
	yield(get_tree().create_timer(2),"timeout")
	
	if Global.AccessToken != "":
		var authheader: PoolStringArray = ['Authorization: Bearer ' + Global.AccessToken ] 
		
		httpNode.connect("request_completed", self, "_on_request_completed_tokenstatus")
		httpNode.request(Global.APIrooturl +  "/api/v1/user/tokenDetails",authheader,false,HTTPClient.METHOD_GET)
	else:
		get_tree().change_scene('res://login/login.tscn')
			
	
		

func _on_request_completed_tokenstatus(result, response_code,headers, body):	
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	if response_code == 200:
		get_tree().change_scene('res://game/title_screen/TitleScreen.tscn')
	else:	
		labelnode.text = "Login Expired! \n Redirecting..."
		yield(get_tree().create_timer(2),"timeout")
		get_tree().change_scene('res://login/login.tscn')
	
