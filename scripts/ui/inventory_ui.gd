extends PanelContainer

@onready var log_label: Label = $MarginContainer/VBoxContainer/Logs/LogLabel
@onready var stone_label: Label = $MarginContainer/VBoxContainer/Stone/StoneLabel
@onready var milk_label: Label = $MarginContainer/VBoxContainer/Milk/MilkLabel
@onready var egg_label: Label = $MarginContainer/VBoxContainer/Egg/EggLabel


func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)


func on_inventory_changed() -> void:
	var inventory : Dictionary = InventoryManager.inventory
	
	if inventory.has("LOG.NAME"):
		log_label.text = str(inventory["LOG.NAME"])

	if inventory.has("GOLD.NAME"):
		stone_label.text = str(inventory["GOLD.NAME"])
		
	if inventory.has("Milk"):
		milk_label.text = str(inventory["Milk"])
		
	if inventory.has("Egg"):
		egg_label.text = str(inventory["Egg"])
