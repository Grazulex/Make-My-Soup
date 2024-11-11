extends NodeState

@export var player : Player
@export var animation_player : AnimationPlayer

var direction : Vector2

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	if player.direction == Vector2.UP:
		animation_player.play("idle_back")
	elif player.direction  == Vector2.RIGHT:
		animation_player.play("idle_right")
	elif player.direction  == Vector2.DOWN:
		animation_player.play("idle_front")
	elif player.direction  == Vector2.LEFT:
		animation_player.play("idle_left")
	else:
		animation_player.play("idle_front")	
		
	pass

func _on_next_transitions() -> void:
	GameInputEvents.movement_input()
	
	if GameInputEvents.is_movement_input():
		transition.emit("Walking")
		
	if player.current_tool == DataTypes.Tools.AxeWood && GameInputEvents.use_tool():
		transition.emit("Axing")
		
	if player.current_tool == DataTypes.Tools.PickStone && GameInputEvents.use_tool():
		transition.emit("Picking")	

func _on_enter() -> void:
	animation_player.stop()


func _on_exit() -> void:
	pass
