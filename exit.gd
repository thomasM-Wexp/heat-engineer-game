extends Sprite2D



func _on_exit_collision_body_entered(_body) -> void:
	Var.new_level = true
