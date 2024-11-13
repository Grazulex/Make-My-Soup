extends Control

@onready var label_name: Label = $PanelContainer/VBoxContainer/LabelName
@onready var label_description: Label = $PanelContainer/VBoxContainer/LabelDescription

var collectable : Collectable

func _ready() -> void:
	visible = false
	collectable = get_parent() 
	label_name.text = tr(collectable.collectable_name)
	label_description.text = tr(collectable.collectable_description)

func _on_collectable_collect() -> void:
	visible = true


func _on_collectable_exit() -> void:
	visible = false
