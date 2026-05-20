extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Var.catattack.name = 'cat'
	Var.catattack.wait_time = 0.5
	Var.catattack.one_shot = true

func regain() -> void:
	Var.SPEED = 700
	$cats_eyes.set_deferred('monitoring',true)

func _on_cat_entered(_body) -> void:
	$cats_eyes.set_deferred('monitoring',false)
	Var.SPEED = 350
	if !get_node('cat'):
		add_child(Var.catattack)
		Var.catattack.timeout.connect(regain)
	Var.catattack.start()
