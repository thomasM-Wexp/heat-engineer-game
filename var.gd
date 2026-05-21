extends Node

#for main
var room_number = 5
var rng = RandomNumberGenerator.new()
var new_level = false
var pause = false
var heater = preload("res://heater.tscn")
var spawns = [Vector2(-3350,-300),Vector2(0,0),Vector2(-2750,2900),Vector2(-2000,1400),Vector2(900,3000)]
var base = [Vector2(-3750,500),Vector2(1000,0),Vector2(-2900,2950),Vector2(-2000,1400),Vector2(500,2900)]
var cats = [[5,Vector2(750,2325),deg_to_rad(90)],[5,Vector2(1500,2150),deg_to_rad(180)]]#room, position, rotation
var birds = [[4,Vector2(-2600,1700)]]
var dogs = [[1,[Vector2(-4200,-50),Vector2(-4200,300),Vector2(-4000,450),Vector2(-4000,-50),Vector2(-4200,-50)]]]#room, list of points to go to
#for player
var username = ''
var SPEED = 700.0
var active_SPEED = SPEED
var dash = 1.5
var speed_boost = 1
var points = 0
var high_score = 0
var time = 31
var difficulty = 1
var level_timer = Timer.new()
var held_item = null

var catattack = Timer.new()
var bird_hunt = false
var player = 0

#points
var base_cost = 0.26
var solar_discount = 0.00
var efficiency = 300.00
var efficiency_upgrades = [350,400,450,500]
var max_heat = 1000
var heat_used = 100
