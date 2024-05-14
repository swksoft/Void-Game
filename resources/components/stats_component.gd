class_name StatsComponent extends Node

@export var max_hp := 3
@export var max_spd := 5.0

var hp : int
var spd : float

func _ready():
	hp = max_hp
	spd = max_spd

func stat_up(name_stat, amount):
	self[name_stat] += amount
	self["max_" + name] += amount
