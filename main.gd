extends Node2D

signal new_level
#wednesday goals:
#work on score system(after asking about score system)
#ask about visuals
#work on database/leaderboard integration
#work on adding in dog obstacle
#set aiden up with making pause/start menu function and UI

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
	room = 4
	for i in range(len(Var.cats)):
		print(Var.cats[i][0])
		if room == Var.cats[i][0]:
			var instance = $cat_obstacle.duplicate()
			instance.position = Var.cats[i][1]
			instance.rotation = Var.cats[i][2]
			add_child(instance)
			instance.show()
	for i in range(len(Var.birds)):
		print(Var.birds[i][0])
		if room == Var.birds[i][0]:
			var instance = $bird_obstacle.duplicate()
			instance.position = Var.birds[i][1]
			add_child(instance)
			instance.show()
	$player.position = Var.spawns[room-1]
	$heater.position = Var.base[room-1]
	new_level.emit()
