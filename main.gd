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

func get_overlap_area() -> float:
	var rect = []
	var global_rects = []
	var intersections = []
	var intersection = 0
	var total_intersection = 0
	var total_area = 0
	for i in range(get_tree().get_nodes_in_group('heaters').size()):
		rect.append(get_tree().get_nodes_in_group('heaters')[i].get_node('heater_aura/aura').shape.get_rect())
		global_rects.append(get_tree().get_nodes_in_group('heaters')[i].global_transform * rect[i])
	for j in range(len(global_rects)):
		total_area += global_rects[j].get_area()
		for k in range(len(global_rects)):
			if j > k:
				intersection = global_rects[j].intersection(global_rects[k])
				if intersection.position != Vector2(0,0):
					intersections.append(intersection)

	for i in range(len(intersections)):
		total_intersection += intersections[i].get_area()
	if total_area > 0 and total_intersection > 0:
		var usable_area =(total_intersection / total_area) * 100
		return usable_area
	elif total_area > 0 and total_intersection <= 0:
		var usable_area = 100
		return usable_area
	else:
		var usable_area = 0.00
		return usable_area
func calc_points():
	var area_penalty = get_overlap_area()
	#get overlapping sum, make area with it
	var price_penalty = Var.base_cost - Var.solar_discount
	#get price deduction
	var heat_used = 0
	if get_tree().get_nodes_in_group('heaters').size() > 0:
		heat_used = round(Var.heat_used * get_tree().get_nodes_in_group('heaters').size())
	#get max heat to find total heat used
	
	#get efficiency multiplier
	if get_node('GUI/bob'):
		var time_bonus = round(get_node('GUI/bob').time_left)
		#get time, round to nearest 10 for calc
		Var.points += round(((((heat_used / area_penalty) * 100) + (100 * time_bonus)) * Var.efficiency) * (price_penalty)/1000)
		print(round(((((heat_used / area_penalty) * 100) + (100 * time_bonus)) * Var.efficiency) * (price_penalty)/1000)
)
func new_room() -> void:
	calc_points()
	for obj in get_tree().get_nodes_in_group("room_objects"):
		obj.queue_free() #should clear everything in group when new rooms loads
		
	$player.drop()
	Var.pause = false
	Var.new_level = false
	get_tree().call_group("rooms", "on_load")
	var room = Var.rng.randi_range(1, Var.room_number)
	
	for i in range(len(Var.cats)):
		if room == Var.cats[i][0]:
			var instance = $cat_obstacle.duplicate()
			instance.position = Var.cats[i][1]
			instance.rotation = Var.cats[i][2]
			instance.add_to_group("room_objects")#add to group so it can be cleared
			add_child(instance)
			instance.show()
			
			
	for i in range(len(Var.birds)):
		if room == Var.birds[i][0]:
			var instance = $bird_obstacle.duplicate()
			instance.position = Var.birds[i][1]
			instance.add_to_group("room_objects")#add to group so it can be cleared
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
			path.add_to_group("room_objects")#add to group so it can be cleared
			path.add_child(instance)
			instance.show()
			
			
			
	$player.position = Var.spawns[room-1]
	$heater.position = Var.base[room-1]
	new_level.emit()
