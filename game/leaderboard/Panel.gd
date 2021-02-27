extends Panel

onready var httpNode = $HTTPRequest

func _ready():
	httpNode.connect("request_completed", self, "_on_request_completed")
	httpNode.request("http://www.mocky.io/v2/5185415ba171ea3a00704eed")
	
func _on_request_completed(result, response_code,headers, body):	
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	var shift = 0.0
	if json != null:
		for player in json.result:
			var lbl = Label.new()
			lbl.align = Label.ALIGN_CENTER
			lbl.text = player
			var labelsize = lbl.get_combined_minimum_size().x
			var center = (self.rect_size.x - labelsize) / 2
			lbl.set_position(Vector2(center,50.0+shift))
			self.add_child(lbl)
			shift

