extends Control

const API_URL = "https://usrqrovuermpqwsztwkd.supabase.co/rest/v1/"
const API_KEY = "sb_publishable_kgL5cXlKcazN57q_9hXUKg_NJ1m94ST"

@onready var http = $HTTPRequest
@onready var container = $Panel/ColorRect/VBoxContainer/ScrollContainer/BoxContainer/VBoxContainer


var table = "global_leaderboard"
var floors = "5"

func _ready():
	http.request_completed.connect(_on_data_received)
	fetch()
	
func fetch():
	for child in container.get_children():
		child.queue_free()
	var headers = [
		"apikey: " + API_KEY,
		"Authorization: Bearer " + API_KEY
		]
	http.request(API_URL + table + "?floors=eq." + floors + "&order=score.desc&limit=10", headers)


func _on_data_received(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	
	if json == null:
		return
	
	var count = 0
	for entry in json:
		var label = Label.new()
		
		label.text = "%s — %s pts" % [entry["player_name"], entry["score"]]
			# size
		label.custom_minimum_size = Vector2(0, 40)
	
	# font size
		label.add_theme_font_size_override("font_size", 24)
	
	# colour
		label.add_theme_color_override("font_color", Color(1, 1, 1))  # white
		
		if count==0:
			label.add_theme_color_override("font_color", Color(1.0, 0.878, 0.0, 1.0))
		
		if count == 1:
			label.add_theme_color_override("font_color", Color(0.558, 0.558, 0.558, 1.0))
		if count == 2:
			label.add_theme_color_override("font_color", Color(0.686, 0.353, 0.165, 1.0))
		count+=1
		
	# alignment
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		container.add_child(label)


#10easy filter button
func _on_button_pressed() -> void:
	table = "global_leaderboard"
	floors = "10"
	fetch()

#5 easy filter button
func _on_5easy_btn_pressed() -> void:
	table = "global_leaderboard"
	floors = "5"
	fetch()

#15 easy filter button
func _on_15easy_btn_pressed() -> void:
	table = "global_leaderboard"
	floors = "15"
	fetch()


func _on_endless_pressed() -> void:
	table = "global_leaderboard"
	floors = "endless"
	fetch()

#Normal leaderboard filters
func _on_5normal_btn_pressed() -> void:
	table = "normal_leaderboard"
	floors = "5"
	fetch()


func _on_10normal_btn_pressed() -> void:
	table = "normal_leaderboard"
	floors = "10"
	fetch()


func _on_15normal_btn_pressed() -> void:
	table = "normal_leaderboard"
	floors = "15"
	fetch()


func _on_normal_endless_pressed() -> void:
	table = "normal_leaderboard"
	floors = "endless"
	fetch()

#hard leaderboard Filters
func _on_5hard_btn_pressed() -> void:
	table = "hard_leaderboard"
	floors = "5"
	fetch()


func _on_10hard_btn_pressed() -> void:
	table = "hard_leaderboard"
	floors = "10"
	fetch()


func _on_15hard_btn_pressed() -> void:
	table = "hard_leaderboard"
	floors = "15"
	fetch()


func _on_hard_endless_pressed() -> void:
	table = "hard_leaderboard"
	floors = "endless"
	fetch()
