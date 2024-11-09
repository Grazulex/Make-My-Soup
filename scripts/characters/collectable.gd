extends StaticBody2D
class_name Collectable

@export var collectable_point : int = 1
@export var collectable_name : String = ""
@export_multiline var collectable_description : String = ""

signal collect(item: Collectable)

func _ready() -> void:
	add_to_group("collectable")
	collect.connect(_on_collect)
	pass 

func _process(_delta: float) -> void:
	pass

func _on_collect(item : Collectable) -> void:
	print("get: " + item.collectable_name)
	item.queue_free()
