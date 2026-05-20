extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _process(_delta) -> void:
	if Engine.get_process_frames() % 5 == 0 and Var.bird_hunt == true:
		$bird_sprite.position = Var.player - self.position + Vector2(Var.rng.randi_range(-10,10),Var.rng.randi_range(-10,10))

func _on_domain_entered(_body: Node2D) -> void:
	Var.bird_hunt = true
	Var.SPEED = 550


func _on_domain_exited(_body: Node2D) -> void:
	Var.bird_hunt = false
	Var.SPEED = 700
	$bird_sprite.position = $bird_collision.position
