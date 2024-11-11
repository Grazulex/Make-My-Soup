extends PanelContainer

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_pick: Button = $MarginContainer/HBoxContainer/ToolPick


func _ready() -> void:
	ToolManager.enable_tool.connect(on_enable_tool_button)
	
	#tool_pick.disabled = true
	#tool_pick.focus_mode = Control.FOCUS_NONE

	
func _on_tool_axe_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.AxeWood)
	
func _on_tool_pick_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.PickStone)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("release_tool"):
		ToolManager.select_tool(DataTypes.Tools.None)
		tool_axe.release_focus()
		tool_pick.release_focus()

func on_enable_tool_button(tool : DataTypes.Tools) -> void:
	if tool == DataTypes.Tools.PickStone:
		tool_pick.disabled = false
		tool_pick.focus_mode = Control.FOCUS_ALL
