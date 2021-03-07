extends Control


onready var httpNode = $HTTPRequest
onready var username = $TextureRect2/VBoxContainer/Username
onready var password = $TextureRect2/VBoxContainer/Password
onready var alertpopup = $TextureRect2/PopupDialog
onready var alertLabel = $TextureRect2/PopupDialog/Label

var dict = {} 

func _ready():
	var file = File.new()
	file.open("res://config.json", file.READ)
	var text = file.get_as_text();
	dict = parse_json(text);
	file.close();
	if dict["Username"] != "" && dict["Password"] != "":
		username.text = dict["Username"]
		password.text = dict["Password"] 
	
func _on_submit_pressed():
	if username.text == "" || password.text == "":
		alertLabel.text = "Please key in \n both username \n and password!"
		alertpopup.popup()
	else:
		var query = "username="+username.text+"&password=" +password.text;
		print(query)
		var headers: PoolStringArray = []
		httpNode.connect("request_completed", self, "_on_request_completed")
		httpNode.request("http://cz3003arsenal.southeastasia.cloudapp.azure.com:8080/login",headers,false,HTTPClient.METHOD_POST,query)
		
	
func _on_request_completed(result, response_code,headers, body):	
	var json = JSON.parse(body.get_string_from_utf8())
	print(body.get_string_from_utf8())
	
	if response_code!=200 || json.result["status"] != 200:
		alertLabel.text = "Login failed! \n Please try again!"
		alertpopup.popup()
	
	
	get_tree().change_scene('res://game/title_screen/TitleScreen.tscn')

	pass
	

func _on_enter_pressed():
	
	alertpopup.visible = false;
