extends CharacterBody2D

@export var speed = 500
@onready var timer = $Timer

func _physics_process(delta):
	move_and_slide()
	if (global_position.y<55): 
		global_position.y=55
	if (global_position.y>480):
		global_position.y=480
