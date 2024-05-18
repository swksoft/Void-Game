extends Area2D
class_name HurtboxComponent

@export var stats_component: StatsComponent
@export var health_component: HealthComponent
@export var parent : CharacterBody2D

func _on_area_entered(area):
	if area is HitboxComponent:
		print_debug("Daño")
