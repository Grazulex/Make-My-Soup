extends CharacterBody2D
class_name  Player

@onready var player_animation: AnimationPlayer = $PlayerAnimation

@export var speed : float = 300.0

var direction : Vector2
var last_direction : Vector2

func _physics_process(_delta : float) -> void:
	if Input.is_action_pressed("ui_left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("ui_up"):
		direction = Vector2.UP
	else:
		direction = Vector2.ZERO
		
	if direction != Vector2.ZERO:
		last_direction = direction

	velocity = direction * speed
			
	update_animation()		
	move_and_slide()

func update_animation():
	if velocity.y < 0 :
		player_animation.play("walk_back")
	elif velocity.x > 0:
		player_animation.play("walk_right")
	elif velocity.y > 0:
		player_animation.play("walk_front")
	elif velocity.x < 0:
		player_animation.play("walk_left")
	else:
		if last_direction == Vector2.LEFT:
			player_animation.play("idle_left")
		elif last_direction == Vector2.RIGHT:
			player_animation.play("idle_right")
		elif last_direction == Vector2.UP:
			player_animation.play("idle_back")
		elif last_direction == Vector2.DOWN:
			player_animation.play("idle_front")
		else:
			player_animation.play("idle_front")	
