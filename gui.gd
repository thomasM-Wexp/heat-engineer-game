extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func on_timeout() -> void:
	print("aaa")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	$score.text = "High score: "+str(Var.high_score)+"\n Your score: "+str(Var.points)
	if get_node('bob'):
		$time.text = "time left: "+str(round(get_node('bob').time_left))

func _on_new_level() -> void:
	Var.level_timer.name = 'bob'
	Var.level_timer.wait_time = Var.time - Var.difficulty
	Var.level_timer.one_shot = true
	Var.level_timer.timeout.connect(on_timeout)
	if !get_node('bob'):
		add_child(Var.level_timer)
	Var.level_timer.start()
