extends Control

@onready var main_game = preload("res://Scenes/main_game.tscn")

func _on_start_pressed():
	get_tree().change_scene_to_packed(main_game)

func _on_quit_pressed():
	get_tree().quit()
