extends Control


onready var continue_button = $Background/Column/TitleScreenButton
onready var items_button = $Background/Column/CancelButton

onready var buttons_container = $Background/Column

func _ready():
	pass

func _on_Player_died():
	items_button.disabled = true

func open(args={}):
	.open()
	continue_button.grab_focus()

func backToHome():
	pass # Replace with function body.

func _on_Button_pressed():
	get_tree().change_scene('res://game/title_screen/TitleScreen.tscn')
