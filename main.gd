extends Node2D

signal new_level
#wednesday goals:
#work on difficulty rating the levels
#work on score system(after asking about score system)
#ask about visuals
#work on immovable obstacles(immovable table, movable sofa, change point deductions based off of immovables)
#work on movable obstacles(cat, camps set area, stuns on hit, dog, patrols set area, blocks and pushes, bird, watches set area, slows when in area)
#make more maps


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_room()

func _process(_delta) -> void:
	if Var.new_level == true:
		new_room()

func new_room() -> void:
	$player.drop()
	Var.pause = false
	Var.new_level = false
	get_tree().call_group("rooms", "on_load")
	var room = Var.rng.randi_range(1, Var.room_number)
	for i in range(len(Var.cats)):
		print(Var.cats[i][0])
		if room == Var.cats[i][0]:
			var instance = $cat_obstacle.duplicate()
			instance.position = Var.cats[i][1]
			instance.rotation = Var.cats[i][2]
			add_child(instance)
	$player.position = Var.spawns[room-1]
	$heater.position = Var.base[room-1]
	new_level.emit()
