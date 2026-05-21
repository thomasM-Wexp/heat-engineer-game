extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control.hide()

func on_timeout() -> void:
	Var.pause = true
	get_tree().change_scene_to_file("res://start_menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	$score.text = "High score: "+str(Var.high_score)+"\n Your score: "+str(Var.points)
	if get_node('bob'):
		$time.text = "time left: "+str(round(get_node('bob').time_left))

func _on_new_level() -> void:
	Var.level_timer.name = 'bob'
	Var.level_timer.wait_time = Var.time - Var.difficulty
	Var.level_timer.one_shot = true
	
	if !get_node('bob'):
		add_child(Var.level_timer)
		Var.level_timer.timeout.connect(on_timeout)
	Var.level_timer.start()

func _unhandled_input(_event) -> void:
	if Input.is_action_just_pressed('menu'):
		$Control.visible = !$Control.visible
		if get_node('bob') and get_node('bob').time_left > 0.9:
			get_node('bob').paused = !get_node('bob').paused
		get_tree().paused = !get_tree().paused
