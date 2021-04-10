extends Control
onready var httpNode = $HTTPRequest
onready var username = $TextureRect2/Username
onready var password = $TextureRect2/Password
onready var alertpopup = $TextureRect2/PopupDialog
onready var alertLabel = $TextureRect2/PopupDialog/Label


func _ready():
	if Global.Username != "" :
		username.text = Global.Username
		
func _on_submit_pressed():
	if username.text == "" || password.text == "":
		alertLabel.text = "Please key in \n both username \n and password!"
		alertpopup.popup()
	else:
		var query = to_json({"username":username.text,"password": password.text});
		var headers = ["Content-Type: application/json","Content-Length: " + str(query.length())] 

		httpNode.connect("request_completed", self, "_on_request_completed_login")
		httpNode.request(Global.APIrooturl +  "/login/v2",headers,false,HTTPClient.METHOD_POST,query)
		
		
func _on_request_completed_login(result, response_code,headers, body):	
	var json = JSON.parse(body.get_string_from_utf8())
	if response_code == 200:
		var time = OS.get_unix_time()
		Global.updateConfig({"Username":username.text, "AccessToken":json.result["access_token"], "TokenExpire": json.result["expires_in"], "lastlogin":time })
		Global.AccessToken = json.result["access_token"];
		httpNode.disconnect("request_completed",self,"_on_request_completed_login")
	
		var authheader: PoolStringArray = ['Authorization: Bearer ' + Global.AccessToken ] 
	
	
		httpNode.connect("request_completed", self, "_on_request_commpleted_profile")
		httpNode.request(Global.APIrooturl +  "/api/v1/user/profile",authheader,false,HTTPClient.METHOD_GET)
		
	else:
		alertLabel.text = "Login failed! \n Please try again!"
		alertpopup.popup()

func _on_request_commpleted_profile(result, response_code,headers, body):	
	var json = JSON.parse(body.get_string_from_utf8())
	if response_code == 200:
		Global.updateConfig({ "Playerid" : json.result["id"] })
	
		get_tree().change_scene('res://game/title_screen/TitleScreen.tscn')
	else:
		httpNode.disconnect("request_completed",self,"_on_request_commpleted_profile")
		alertLabel.text = "Login failed! \n Please try again!"
		alertpopup.popup()
		httpNode.connect("request_completed", self, "_on_request_completed_login")
		
func _on_enter_pressed():
	alertpopup.visible = false;
