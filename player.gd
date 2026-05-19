extends CharacterBody2D



const ACCELLERATION = 2100.0
const DRAG = 2100.0



func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right",'up', 'down')
	velocity = direction * Var.SPEED
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * Var.SPEED, ACCELLERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DRAG * delta)
	if Input.is_action_just_pressed("run"):
		if Var.SPEED == 700:
			Var.SPEED = 700 * (Var.speed_boost * Var.dash)
		else:
			Var.SPEED = Var.SPEED / Var.dash
	look_at(get_global_mouse_position())

	move_and_slide()
