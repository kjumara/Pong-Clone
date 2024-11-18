extends Area2D

@export var speed = Vector2(300, 150)

@onready var wall_hit_sound = $Wall_Hit_Sound
@onready var paddle_hit_sound = $Paddle_Hit_Sound

func _physics_process(delta):
	global_position -= speed*delta

#enemy or player paddle hit
func _on_body_entered(body):
	var pitch = randf_range(0.75,1.25)
	paddle_hit_sound.pitch_scale = pitch
	paddle_hit_sound.play()
	redirect()

#hitting wall or powerup
func _on_area_entered(area):
	if area.is_in_group("powerup"):
		pass
	else:
		var pitch = randf_range(0.75,1.25)
		wall_hit_sound.pitch_scale = pitch
		wall_hit_sound.play()
		speed.y = -speed.y

func redirect():
	var dir_y = randf()
	if dir_y>0.5: speed.y = speed.y
	speed.x = -speed.x
