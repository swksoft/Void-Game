extends Area2D
class_name HitboxComponent

@export var attacker : Node2D
@export var damage: float = 1

var is_blackhole := false

func _ready():
	print_debug(is_in_group("BlackHole"))

func target_player():
	set_collision_layer_value(2, true)

func target_enemy():
	set_collision_layer_value(1, true)
