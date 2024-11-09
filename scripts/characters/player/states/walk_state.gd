extends NodeState

@export var player : Player
@export var animation_player : AnimationPlayer
@export var speed : int = 50

var colliders_actif : Array[Collectable]

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
	var detections_actif : bool = false
	for detection_characters in player.detection_ray_cat:
		if detection_characters.is_colliding():
			detections_actif = true
			detection_characters.enabled = false
			var collider = detection_characters.get_collider()
			colliders_actif.append(collider)
			if (collider.is_in_group("collectable")):
				collider.emit_signal("collect")
			if (collider.is_in_group("enemy")):
				collider.emit_signal("hurt")
			if (collider.is_in_group("npc")):
				collider.emit_signal("hit")				
			detection_characters.enabled = true		
	
	if !detections_actif:
		for collider in colliders_actif:
			if is_instance_valid(collider):
				if (collider.is_in_group("collectable")):
					collider.emit_signal("exit")
				colliders_actif.erase(collider)
