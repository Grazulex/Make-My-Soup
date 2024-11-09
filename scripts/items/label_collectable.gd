extends Control

@onready var label_name: Label = $PanelContainer/VBoxContainer/LabelName
@onready var label_description: Label = $PanelContainer/VBoxContainer/LabelDescription

var collectable : Collectable

func _ready() -> void:
	collectable = get_parent() 
	label_name.text = collectable.collectable_name
	label_description.text = collectable.collectable_description
