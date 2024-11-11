extends PanelContainer

@onready var log_label: Label = $MarginContainer/VBoxContainer/Logs/LogLabel
@onready var stone_label: Label = $MarginContainer/VBoxContainer/Stone/StoneLabel
@onready var milk_label: Label = $MarginContainer/VBoxContainer/Milk/MilkLabel


func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)


func on_inventory_changed() -> void:
	var inventory : Dictionary = InventoryManager.inventory
	
	if inventory.has("Log"):
		log_label.text = str(inventory["Log"])

	if inventory.has("Gold"):
		stone_label.text = str(inventory["Gold"])
		
	if inventory.has("Milk"):
		milk_label.text = str(inventory["Milk"])
