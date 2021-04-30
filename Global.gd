extends Node

onready var httpNode = HTTPRequest.new();

var APIrooturl = "http://cz3003.southeastasia.cloudapp.azure.com:8080";
var dict = {} 
var AccessToken;

var character = 1;
var pvelvl;
var pvesection;
var pveworld;

var Username;
var TokenExpire;
var lastlogin;
var pvebossselection;
var playerid;
var WorldsDetails = {};

var worldmapper = {"Surfing on Python": "world1",  "Surfing on PHP": "world2", "Surfing on Java" : "world3"}

var currentlevels;

func _ready():
	var file = File.new()
	file.open("res://config.json", file.READ);
	var text = file.get_as_text();
	dict = parse_json(text);
	file.close();
	
	Username = dict["Username"];
	AccessToken = dict["AccessToken"];
	TokenExpire = dict["TokenExpire"];
	lastlogin = dict["lastlogin"];
	playerid = dict["Playerid"];
	APIrooturl = dict["ApiUrl"];
	
	if AccessToken != "" and lastlogin !=0:
		
		var now = OS.get_unix_time();
		var diff = (now - lastlogin) / 60; 
		if diff < 1440 and diff > 0:
			var query = "?token=" + AccessToken;
			httpNode.connect("request_completed", self, "_on_request_completed_renewtoken");
			httpNode.request(APIrooturl +  "/renewtoken" + query,[],false,HTTPClient.METHOD_POST)
		
	
func updateConfig(obj={}):
	var file = File.new()
	for key in obj:
		dict[key] = obj[key];
	
	file.open("res://config.json", File.WRITE)
	file.store_string(JSON.print(dict, "  ", true))
	file.close()
	pass # Replace with function body.
	

func _on_request_completed_renewtoken(result, response_code,headers, body):	
	var json = JSON.parse(body.get_string_from_utf8())
	
	if response_code == 200:
		var time = OS.get_unix_time()
		Global.updateConfig({"AccessToken":json.result["access_token"], "TokenExpire": json.result["expires_in"], "lastlogin":time })
		Global.AccessToken = json.result["access_token"];
		get_tree().change_scene('res://game/title_screen/TitleScreen.tscn');
	
