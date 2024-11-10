extends StaticBody2D
class_name Collectable

@onready var label_collectable: Control = $LabelCollectable

@export var collectable_point : int = 1
@export var collectable_name : String = ""
@export_multiline var collectable_description : String = ""

signal collect()
signal exit()

var action_key : String = "get" 
var is_nearby : bool = false

func _ready() -> void:
	add_to_group("collectable")
	label_collectable.visible = false
	collect.connect(_on_collect)
	exit.connect(_on_exit)

func _process(_delta: float) -> void:
	if is_nearby and Input.is_action_just_pressed(action_key):
		print("get: " + collectable_name)
		InventoryManager.add_collectable(collectable_name)
		queue_free()

func _on_collect() -> void:
	print("detect: " + collectable_name)
	is_nearby = true
	label_collectable.visible = true
	
func _on_exit() -> void:
	is_nearby = false
	label_collectable.visible = false
