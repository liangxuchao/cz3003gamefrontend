extends Node



var dict = {} 
var AccessToken;
var pvelvlselection;
var APIrooturl;
var Username;

func _ready():
	var file = File.new()
	file.open("res://config.json", file.READ);
	var text = file.get_as_text();
	dict = parse_json(text);
	file.close();
	
	Username = dict["Username"];
	
	APIrooturl = dict["APIrooturl"];
	AccessToken = dict["AccessToken"];

func updateConfig(key,value):
	var file = File.new()
	dict[key] = value;
	file.open("res://config.json", File.WRITE)
	file.store_string(JSON.print(dict, "  ", true))
	file.close()
	pass # Replace with function body.
	
