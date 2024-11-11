extends NodeState

@export var player : Player
@export var animation_player : AnimationPlayer
@export var speed : int = 50

var collider_actif

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
	checkEnableDetection()

func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")
	pass


func _on_enter() -> void:
	ToolManager.select_tool(DataTypes.Tools.None)

func _on_exit() -> void:
	pass

func checkEnableDetection() -> void:
	if ToolManager.selected_tool != DataTypes.Tools.None:
		return
	var detections_actif : bool = false
	for detection_characters in player.detection_ray_cat:
		if detection_characters.is_colliding():
			detections_actif = true
			detection_characters.enabled = false
			var collider = detection_characters.get_collider()
			if collider_actif != collider:
				collider_actif = collider
			if (collider.is_in_group("collectable")):
				collider.emit_signal("collect")
			if (collider.is_in_group("npc")):
				collider.emit_signal("hit")				
			detection_characters.enabled = true		
	if !detections_actif:
		if collider_actif != null:
			if is_instance_valid(collider_actif):
				if (collider_actif.is_in_group("collectable")):
					collider_actif.emit_signal("exit")
				if (collider_actif.is_in_group("npc")):
					collider_actif.emit_signal("exit")				
				collider_actif = null
