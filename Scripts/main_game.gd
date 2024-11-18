extends Node2D

@export var enemy_score = 0
@export var player_score = 0

@onready var ball = $Ball
@onready var enemy = $Enemy
@onready var ball_pos = $Ball.global_position
@onready var hud = $UI/HUD
@onready var ui = $UI
@onready var player = $Player

@onready var speeduptimer = $PowerUpTimers/SpeedUpTimer
@onready var slowdowntimer = $PowerUpTimers/SlowDownTimer

@onready var point_sound = $Sounds/Point_Sound
@onready var powerup_sound = $Sounds/Power_Up_Sound

var direction

var game_over_screen = preload("res://Scenes/end_screen.tscn")
var ball_scene = preload("res://Scenes/ball.tscn")

func _ready():
	hud.set_enemy_score_label(enemy_score)
	hud.set_user_score_label(player_score)
	
func _physics_process(delta):
	var ball_y_pos = ball.global_position.y
	var enemy_y_pos = enemy.global_position.y
	direction = 0
	if abs(ball_y_pos-enemy_y_pos)>25:
		if ball_y_pos>enemy_y_pos:
			direction = 1
		else:
			direction = -1
	
func _on_killzone_area_entered(area):
	if area.global_position.x<100:
		increment_enemy_score()
	else:
		increment_player_score()
	if area.is_in_group("bonus_ball"):
		area.queue_free()
	else:
		area.global_position = ball_pos
		area.redirect()
	
func increment_enemy_score():
	enemy_score+=1
	hud.set_enemy_score_label(enemy_score)
	if enemy_score>=5:
		game_over()
	pass

func increment_player_score():
	point_sound.play()
	player_score+=1
	hud.set_user_score_label(player_score)
	if player_score%3==0:
		enemy.speed+= enemy.speed*0.1
		ball.speed+= ball.speed*0.1
	pass

func game_over():
	var end_screen = game_over_screen.instantiate()
	end_screen.set_score_label(player_score)
	ball.speed = Vector2(0,0)
	ui.add_child(end_screen)

func _on_enemy_movement_timer_timeout():
	enemy.velocity.y = direction*enemy.speed


func _on_ball_area_entered(area):
		if area.is_in_group("powerup"):
			if area.is_in_group("speed_up"):
				powerup_sound.pitch_scale = 2.0
				player.speed *= 1.5
				speeduptimer.start()
			if area.is_in_group("slow_down"):
				powerup_sound.pitch_scale = 0.5
				enemy.speed*=.75
				slowdowntimer.start()
			if area.is_in_group("split_ball"):
				powerup_sound.pitch_scale = 0.5
				var ball_instance = ball_scene.instantiate()
				ball_instance.global_position = ball.global_position
				ball_instance.speed = ball.speed*1.1
				ball_instance.add_to_group("bonus_ball")
				add_child(ball_instance)
			powerup_sound.play()
			area.queue_free()

func _on_speed_up_timer_timeout():
	player.speed /=1.5

func _on_slow_down_timer_timeout():
	enemy.speed/=0.75
