extends CharacterBody2D
class_name Npc

@export var npc_name : String = ""
@export_multiline var npc_description : String = ""

signal hit(npc: Npc)

func _ready() -> void:
	add_to_group("npc")
	hit.connect(_on_hit)
	pass 

func _process(_delta: float) -> void:
	pass

func _on_hit(npc : Npc) -> void:
	print("get: " + npc.npc_name)
