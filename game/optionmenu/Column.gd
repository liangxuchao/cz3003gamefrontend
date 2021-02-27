extends VBoxContainer

var focus_active = true setget set_focus_active

func _ready():
	self.focus_active = focus_active

func set_focus_active(value):
	focus_active = true
	var focus_mode = FOCUS_ALL if focus_active else FOCUS_NONE
	for child in get_children():
		child.focus_mode = focus_mode
