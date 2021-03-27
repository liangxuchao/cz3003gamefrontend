extends Control

onready var httpNode = $HTTPRequest
var scene_path_to_load

func _ready():
	$Menu/CenterRow/Buttons/pveBtn.grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	
	
	var authheader: PoolStringArray = ['Authorization: Bearer ' + Global.AccessToken ] 
	
	httpNode.connect("request_completed", self, "_on_request_completed_getWorlds")
	httpNode.request(Global.APIrooturl +  "/api/v1/gameSearch",authheader,false,HTTPClient.METHOD_GET)
	

func _on_Button_pressed(scene_to_load):
	if scene_to_load == "quit":
		get_tree().quit();
	
	$FadeIn.show()
	$FadeIn.fade_in()
	scene_path_to_load = scene_to_load
	

func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	get_tree().change_scene(scene_path_to_load)


func _on_request_completed_getWorlds(result, response_code,headers, body):	
	var json = JSON.parse(body.get_string_from_utf8())
	
	if response_code == 200:
		Global.WorldsDetails = json.result
