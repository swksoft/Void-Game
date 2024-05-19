extends Area2D
class_name HitboxComponent

@export var attacker : Node2D
@export var damage: float = 0

func target_player():
	set_collision_layer_value(2, true)

func target_enemy():
	set_collision_layer_value(1, true)
