extends StaticBody2D
class_name Commodity

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var material_damage : int = 1
@export var quantity_hit_before_collectable : int = 3
@export var material_name : String = ""
@export_multiline var material_description : String = ""
@export_category("Collectable")
@export_file() var scene_path : String
@export var parent_node : String

signal gathered(tools : DataTypes.Tools)
signal exit()

var action_key: String = "attack" 
var is_nearby : bool = false
var healt : int
var current_tools : DataTypes.Tools

func _ready() -> void:
	healt = quantity_hit_before_collectable
	add_to_group("commodity")
	gathered.connect(_on_gathered)
	exit.connect(_on_exit)

func _process(_delta: float) -> void:
	if is_nearby and Input.is_action_just_pressed(action_key):
		if current_tools == DataTypes.Tools.AxeWood:
			healt -= material_damage
			sprite_2d.material.set_shader_parameter("shake_intensity", 2.0)
			await get_tree().create_timer(1.0).timeout
			sprite_2d.material.set_shader_parameter("shake_intensity", 0.0)
	if healt == 0:
		ToolsManager.add_new_item(scene_path, parent_node, Vector2(position.x - 20, position.y))
		queue_free()

func _on_gathered(tools : DataTypes.Tools) -> void:
	current_tools = tools
	print("gathered: " + material_name)
	is_nearby = true
	
func _on_exit() -> void:
	print("exit: " + material_name)
	is_nearby = false
