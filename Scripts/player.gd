extends CharacterBody2D

@export var speed = 200;

func _physics_process(delta):
	velocity = Vector2(0,0)
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_down"):
		velocity.y= speed
	
	move_and_slide()
	
	if (global_position.y<55): 
		global_position.y=55
	if (global_position.y>480):
		global_position.y=480
