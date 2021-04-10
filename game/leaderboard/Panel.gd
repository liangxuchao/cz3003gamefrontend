extends Panel

onready var httpNode = $HTTPRequest

func _ready():
	httpNode.connect("request_completed", self, "_on_request_completed")
	#httpNode.request("http://www.mocky.io/v2/5185415ba171ea3a00704eed")
	httpNode.request("https://data.gov.sg/api/action/datastore_search?resource_id=b2871270-4eef-44a3-be98-908e2a73b19f")
func _on_request_completed(result, response_code,headers, body):	
	var json = JSON.parse(body.get_string_from_utf8())
	var shift = 0.0
	var i = 1
	if json != null:
		for player in json.result["result"]["records"]:
			i=i+1
			if i == 50:
				break
			else:
				var lbl = Label.new()
				lbl.align = Label.ALIGN_CENTER
				lbl.text = player.name
				lbl.add_color_override("font_color",Color(0.5,0.66,0.48))
				var dynamic_font = DynamicFont.new()
				dynamic_font.font_data = load("res://public/fonts/soupofjustice.ttf")
				dynamic_font.size = 20
				lbl.set("custom_fonts/font",dynamic_font)
				$ScrollContainer/VBoxContainer.add_child(lbl)
				

				
				 
		
	
			
			

