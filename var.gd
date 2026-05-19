extends Node

#for main
var room_number = 2
var rng = RandomNumberGenerator.new()
var new_level = false
var pause = false
var spawns = [Vector2(-4200,100),Vector2(0,0)]

#for player
var SPEED = 700.0
var dash = 1.5
var speed_boost = 1
var points = 0
var high_score = 0
var time = 31
var difficulty = 1
var level_timer = Timer.new()
