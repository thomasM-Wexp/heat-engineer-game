extends Node


const API_URL = "https://usrqrovuermpqwsztwkd.supabase.co/rest/v1/"
const API_KEY = "sb_publishable_kgL5cXlKcazN57q_9hXUKg_NJ1m94ST"

func submit_score(table: String, player_name: String, score: int, floors: String):
	var http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_score_submitted)
	
	var headers = [
		"apikey: " + API_KEY,
		"Authorization: Bearer " + API_KEY,
        "Content-Type: application/json"
	]
	
	var body = JSON.stringify({"player_name": player_name, "score": score, "floors": floors})
	http.request(API_URL + table, headers, HTTPClient.METHOD_POST, body)

func _on_score_submitted(result, response_code, headers, body):
	print("Score submitted: ", response_code)
