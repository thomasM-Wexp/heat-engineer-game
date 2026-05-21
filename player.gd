extends CharacterBody2D



const ACCELLERATION = 2100.0
const DRAG = 2100.0
@onready var hold_position = $hands
@onready var interact_ray = $grabber



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
	if Var.pause == false:
		look_at(get_global_mouse_position())
		move_and_slide()
		Var.player = self.position

func _input(event):
	if event.is_action_pressed("interact"):
		if Var.held_item:
			drop()
		else:
			grab()
			
func grab():
	var collider = interact_ray.get_collider()
	if collider and collider.has_method("pick_up") and get_tree().get_nodes_in_group('heaters').size() < round((Var.max_heat / Var.heat_used)):
		Var.held_item = Var.heater.instantiate()
		get_tree().root.add_child(Var.held_item)
		Var.held_item.pick_up(hold_position)
		Var.held_item.add_to_group("heaters")

func drop():
	if Var.held_item:
		Var.held_item.drop(global_position, get_tree().current_scene)
		Var.held_item = null
