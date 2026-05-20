extends Node2D

signal new_level
#wednesday goals:
#ask about visuals
#work on adding in dog obstacle

#thursday goals:
#add in heater aura's
#add in more maps
#add in difficulty scaling and difficulty ranking
#add in score calculations
#add in username
#add in score saving
#add in visuals

# Called when the node enters the scene tree for the first time.

func _process(_delta) -> void:
	if Var.new_level == true:
		new_room()

func new_room() -> void:
	$player.drop()
	Var.pause = false
	Var.new_level = false
	get_tree().call_group("rooms", "on_load")
	var room = Var.rng.randi_range(1, Var.room_number)
	room = 1
	
	for i in range(len(Var.cats)):
		if room == Var.cats[i][0]:
			var instance = $cat_obstacle.duplicate()
			instance.position = Var.cats[i][1]
			instance.rotation = Var.cats[i][2]
			add_child(instance)
			instance.show()
			
	for i in range(len(Var.birds)):
		if room == Var.birds[i][0]:
			var instance = $bird_obstacle.duplicate()
			instance.position = Var.birds[i][1]
			add_child(instance)
			instance.show()
			
	for i in range(len(Var.dogs)):
		if room == Var.dogs[i][0]:
			var path = Path2D.new()
			var curve = Curve2D.new()
			for j in range(len(Var.dogs[i][1])):
				curve.add_point(Var.dogs[i][1][j])
			path.curve = curve
			add_child(path)
			var instance = $pathfinding/dog_walk.duplicate()
			instance.position = Var.dogs[i][1][0]
			path.add_child(instance)
			instance.show()
			
			
	$player.position = Var.spawns[room-1]
	$heater.position = Var.base[room-1]
	new_level.emit()
