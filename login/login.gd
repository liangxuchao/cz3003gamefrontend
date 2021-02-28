extends Control


onready var httpNode = $HTTPRequest
onready var username = $ColorRect/VBoxContainer/Username
onready var password = $ColorRect/VBoxContainer/Password

var dict = {} 

func _ready():
  var file = File.new()
  file.open("res://config.json", file.READ)
  var text = file.get_as_text()
  dict = parse_json(text)
  file.close()

func _on_submit_pressed():
	var headers: PoolStringArray = []
	httpNode.connect("request_completed", self, "_on_request_completed")
	httpNode.request(dict["APIrooturl"],headers,true,HTTPClient.METHOD_GET)

func _on_request_completed(result, response_code,headers, body):	
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result["hello"])
	if json.result["hello"] == "world" :
		get_tree().change_scene('res://game/title_screen/TitleScreen.tscn')

	
