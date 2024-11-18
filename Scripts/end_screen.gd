extends Control

func set_score_label(value):
	$Score.text = "SCORE \n" + str(value)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/title_page.tscn")
