extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var level_scene = preload("res://game/interface/Menu/World3/Select Level.tscn").instance()
func _on_SectionButton2_pressed():
	get_tree().get_root().add_child(level_scene)
	pass # Replace with function body.



