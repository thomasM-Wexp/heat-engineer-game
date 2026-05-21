extends RigidBody2D


func pick_up(new_parent: Node2D):
	$heater_pickup/pickup_collision.disabled = true
	get_parent().remove_child(self)
	new_parent.add_child(self)
	position = Vector2.ZERO

func drop(global_pos: Vector2, world_node: Node):
	$heater_collision.disabled = true
	get_parent().remove_child(self)
	world_node.add_child(self)
	global_position = global_pos
	add_to_group("room_objects")
