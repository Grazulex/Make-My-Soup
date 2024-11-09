extends CharacterBody2D
class_name Enemy

@export var enemy_damage : int = 1
@export var enemy_healt : int = 10
@export var enemy_name : String = ""
@export_multiline var enemy_description : String = ""

signal hurt()

func _ready() -> void:
	add_to_group("ennemy")
	hurt.connect(_on_hurt)
	pass 

func _process(_delta: float) -> void:
	pass

func _on_hurt() -> void:
	print("get: " + enemy_name)
