extends NodeState

@export var player : Player
@export var animation_player : AnimationPlayer

func _ready() -> void:
	pass

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if !animation_player.is_playing():
		transition.emit("Idle")


func _on_enter() -> void:
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
