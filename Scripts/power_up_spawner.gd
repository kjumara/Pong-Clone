extends Node2D

var speed_up_scene = preload("res://Scenes/speed_up.tscn")
var slow_down_scene = preload("res://Scenes/slow_down.tscn")
var split_ball_scene = preload("res://Scenes/split_ball.tscn")
var power_up_scenes = [slow_down_scene, speed_up_scene, split_ball_scene]

@onready var timer = $Timer
@onready var children = $children

func _on_timer_timeout():
	spawn_power_up()
	if randf()>0.65:
		for child in children.get_children():
			child.queue_free()

func spawn_power_up():
	var x_pos = randi_range(50,700)
	var y_pos = randi_range(25,500)
	var rand_power = power_up_scenes.pick_random()
	var power_up_instance = rand_power.instantiate()
	power_up_instance.global_position = Vector2(x_pos,y_pos)
	children.add_child(power_up_instance)
