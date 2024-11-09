extends CharacterBody2D
class_name  Player

@export var current_tool: DataTypes.Tools = DataTypes.Tools.AxeWood
@export var detection_ray_cat : Array[RayCast2D]

@onready var player_animation: AnimationPlayer = $PlayerAnimation
@onready var player_hit_collision_shape: CollisionShape2D = $PlayerHitArea/PlayerHitCollisionShape

var direction = Vector2.ZERO as Vector2

func _ready() -> void:
	player_hit_collision_shape.disabled = true
