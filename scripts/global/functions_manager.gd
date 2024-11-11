extends Node

func find_node_in_children(parent: Node, target_name: String) -> Node:
	for child in parent.get_children():
		if child.name == target_name:
			return child
		var result = find_node_in_children(child, target_name)
		if result:
			return result
	return null

func add_new_item(scene : String, node : String, position : Vector2) -> void:
	var static_body_scene = load(scene)
	var static_body_instance = static_body_scene.instantiate()
	static_body_instance.position = position
	var specific_parent = find_node_in_children(get_tree().root, node)
	specific_parent.add_child(static_body_instance)
