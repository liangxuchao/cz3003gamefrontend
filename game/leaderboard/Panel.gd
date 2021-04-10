extends Panel

onready var httpNode = $HTTPRequest

func _ready():
	var authheader: PoolStringArray = ['Authorization: Bearer ' + Global.AccessToken, 'Content-Type: application/json', ] 
	httpNode.connect("request_completed", self, "_on_request_completed")
	httpNode.request(Global.APIrooturl +  "/api/v1/dashboard/leaderboard",authheader,false,HTTPClient.METHOD_GET)

func _on_request_completed(result, response_code,headers, body):	
	var json = JSON.parse(body.get_string_from_utf8())
	var shift = 0.0
	var i = 1
	
	$ScrollContainer/GridContainer.set_columns(2)
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://public/fonts/soupofjustice.ttf")
	dynamic_font.size = 30
	
	var headerName = Label.new()
	headerName.set_align(Label.ALIGN_LEFT)
	headerName.set_text("NAME")
	headerName.add_color_override("font_color",Color(0.5,0.66,0.48))
	headerName.set("custom_fonts/font",dynamic_font)
	
	var headerScore = Label.new()
	headerScore.set_align(Label.ALIGN_LEFT)
	headerScore.set_text("SCORE")
	headerScore.size_flags_horizontal = Control.SIZE_SHRINK_END + Control.SIZE_EXPAND
	headerScore.add_color_override("font_color",Color(0.5,0.66,0.48))
	headerScore.set("custom_fonts/font",dynamic_font)

	$ScrollContainer/GridContainer.add_child(headerName)
	$ScrollContainer/GridContainer.add_child(headerScore)
	if json != null:
		for player in json.result:
			i=i+1
			if i == 50:
				break
			else:
				var lbl = Label.new()
				lbl.set_align(Label.ALIGN_LEFT)
				lbl.set_text(player.name)
				lbl.add_color_override("font_color",Color(0.5,0.66,0.48))
				lbl.set("custom_fonts/font",dynamic_font)
				$ScrollContainer/GridContainer.add_child(lbl)
				
				var score = Label.new()
				score.set_align(Label.ALIGN_LEFT)
				score.set_text(str(player.score))
				score.size_flags_horizontal = Control.SIZE_SHRINK_END + Control.SIZE_EXPAND
				score.add_color_override("font_color",Color(0.5,0.66,0.48))
				score.set("custom_fonts/font",dynamic_font)
				$ScrollContainer/GridContainer.add_child(score)
				

				
				 
		
	
			
			

