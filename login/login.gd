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
		var query = "?username="+username.text+"&password=" +password.text;
		#print(query)
		#var headers: PoolStringArray = ["Content-Length: " + str(query.length()), 
		#"Content-Type : multipart/form-data; boundary=1", 
		#"HOST: cz3003arsenal.southeastasia.cloudapp.azure.com:8080"] 
		
		httpNode.connect("request_completed", self, "_on_request_completed_login")
		httpNode.request(Global.APIrooturl +  "/login" + query,[],false,HTTPClient.METHOD_POST)
		
		
func _on_request_completed_login(result, response_code,headers, body):	
	var json = JSON.parse(body.get_string_from_utf8())
	
	if response_code == 200:
		print(json.result)
		var time = OS.get_unix_time()
		Global.updateConfig({"Username":username.text, "AccessToken":json.result["access_token"], "TokenExpire": json.result["expires_in"], "lastlogin":time })
		Global.AccessToken = json.result["access_token"];
		get_tree().change_scene('res://game/title_screen/TitleScreen.tscn');
	else:
		alertLabel.text = "Login failed! \n Please try again!"
		alertpopup.popup()


func _on_enter_pressed():
	
	alertpopup.visible = false;
