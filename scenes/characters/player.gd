extends CharacterBody2D
class_name  Player

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
@export var detection_ray_cat : Array[RayCast2D]

@onready var player_animation: AnimationPlayer = $PlayerAnimation
@onready var player_hit_collision_shape: CollisionShape2D = $PlayerHitArea/PlayerHitCollisionShape
@onready var health: Health = $Health

var direction = Vector2.ZERO as Vector2

func _ready() -> void:
	player_hit_collision_shape.disabled = true
	ToolManager.tool_selected.connect(on_tool_selected)
	var commoditiers_node = FunctionsManager.find_node_in_children(get_tree().root,"Commodities")
	for commodity in commoditiers_node.get_children():
		commodity.connect("player_action_healt", on_player_action_healt)
	
func on_tool_selected(tool : DataTypes.Tools) -> void:
	current_tool = tool

func on_player_action_healt(amount : float) -> void:
	health.update_amount(amount)
