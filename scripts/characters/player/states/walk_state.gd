extends NodeState

@export var player : Player
@export var animation_player : AnimationPlayer
@export var speed : int = 50

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	var direction = GameInputEvents.movement_input()
		
	if direction == Vector2.UP:
		animation_player.play("walk_back")
	elif direction == Vector2.RIGHT:
		animation_player.play("walk_right")
	elif direction == Vector2.DOWN:
		animation_player.play("walk_front")
	elif direction == Vector2.LEFT:
		animation_player.play("walk_left")
	else:
		animation_player.play("idle_front")	
		
	if direction != Vector2.ZERO:
		player.direction = direction
		
	player.velocity = direction * speed
	player.move_and_slide()
	checkDetection()

func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")
	pass


func _on_enter() -> void:
	pass

func _on_exit() -> void:
	pass

func checkDetection() -> void:
	for detection_characters in player.detection_ray_cat:
		if detection_characters.is_colliding():
			detection_characters.enabled = false
			var collider = detection_characters.get_collider()
			if (collider.is_in_group("collectable")):
				collider.emit_signal("collect", collider)
			if (collider.is_in_group("enemy")):
				collider.emit_signal("hurt", collider)
			if (collider.is_in_group("npc")):
				collider.emit_signal("hit", collider)				
			detection_characters.enabled = true
