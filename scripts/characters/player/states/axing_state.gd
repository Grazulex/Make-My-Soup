extends NodeState

@export var player : Player
@export var animation_player : AnimationPlayer

var collider_actif

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	checkEnableDetection()

func _on_next_transitions() -> void:
	if !animation_player.is_playing():
		transition.emit("Idle")


func _on_enter() -> void:
	player.current_tool = DataTypes.Tools.AxeWood
	if player.direction == Vector2.UP:
		animation_player.play("axe_back")
	elif player.direction == Vector2.RIGHT:
		animation_player.play("axe_right")
	elif player.direction == Vector2.DOWN:
		animation_player.play("axe_front")
	elif player.direction == Vector2.LEFT:
		animation_player.play("axe_left")
	else:
		animation_player.play("axe_front")

func _on_exit() -> void:
	animation_player.stop()

func checkEnableDetection() -> void:
	if player.current_tool != DataTypes.Tools.AxeWood:
		return
	var detections_actif : bool = false
	for detection_characters in player.detection_ray_cat:
		if detection_characters.is_colliding():
			detections_actif = true
			detection_characters.enabled = false
			var collider = detection_characters.get_collider()
			if collider_actif != collider:
				collider_actif = collider
			if (collider.is_in_group("commodity")):
				collider.emit_signal("gathered", player.current_tool)			
			detection_characters.enabled = true		
	if !detections_actif:
		if collider_actif != null:
			if is_instance_valid(collider_actif):
				if (collider_actif.is_in_group("commodity")):
					collider_actif.emit_signal("exit")			
				collider_actif = null
					
