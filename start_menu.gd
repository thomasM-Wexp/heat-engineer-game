extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_start_btn_pressed() -> void:
	Var.username = $Panel/VBoxContainer/LineEdit.text
	get_tree().change_scene_to_file("res://main.tscn")

	if Var.username == "":
		return 
		
	JavaScriptBridge.eval("localStorage.setItem('player_name', '%s')" % Var.username)
	get_tree().change_scene_to_file("res://main.tscn")

func _on_controls_btn_pressed() -> void:
		get_tree().change_scene_to_file("res://controls_guide.tscn")



func _on_leaderboards_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://leaderboard_skeleton.tscn")


func _on_howtoplay_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://how_to_play.tscn")
