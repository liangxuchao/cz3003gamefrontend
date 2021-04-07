extends Control


func _ready():
	Global.character = 1

func _on_character1_pressed():
	Global.character = 1
	$character1.texture_normal=preload("res://public/image/common/Ninja.png")
	$character2.texture_normal=preload("res://public/image/common/CAPTAIN2.png")
	$character3.texture_normal=preload("res://public/image/common/KNIGHT2.png")


func _on_character2_pressed():
	Global.character = 2
	$character1.texture_normal=preload("res://public/image/common/NINJA2.png")
	$character2.texture_normal=preload("res://public/image/common/CAPTAIN.png")
	$character3.texture_normal=preload("res://public/image/common/KNIGHT2.png")


func _on_character3_pressed():
	Global.character = 3
	$character1.texture_normal=preload("res://public/image/common/NINJA2.png")
	$character2.texture_normal=preload("res://public/image/common/CAPTAIN2.png")
	$character3.texture_normal=preload("res://public/image/common/KNIGHT.png")
