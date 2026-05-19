extends Node2D

signal new_level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_room()

func _physics_process(_delta) -> void:
	if Var.new_level == true:
		new_room()

func new_room() -> void:
	Var.new_level = false
	get_tree().call_group("rooms", "on_load")
	var room = Var.rng.randi_range(1, Var.room_number)
	$player.position = Vector2(0,0)
	if room == 1:
		$"test-room-1".show()
	else:
		$"test-room-2".show()
	$player.collision_layer = room
	$player.collision_mask = room
	new_level.emit()
