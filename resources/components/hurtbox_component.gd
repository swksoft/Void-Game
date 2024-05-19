extends Area2D
class_name HurtboxComponent

@export var stats_component: StatsComponent
@export var health_component: HealthComponent
@export var parent : CharacterBody2D

var colliding_areas = []

@onready var invul_time = $InvulTime

func check_deal_damage():
	if colliding_areas.size() == 0 || !invul_time.is_stopped():
		return
	
	for other_area in colliding_areas:
		if other_area.is_in_group("BlackHole"):
			pass
			#other_area.pierced += 1
			#if other_area.pierced >= other_area.max_pierce: other_area.queue_free()
		
		var hitbox_component = other_area as HitboxComponent
		
		health_component.damage(hitbox_component.damage)
		
		if other_area.attacker != null && other_area.attacker is Player:
			var player : Player = other_area.attacker
			player.did_damage.emit(hitbox_component.dmg)
	
	invul_time.start()

func _on_area_entered(area: Area2D):
	if not area is HitboxComponent: return
	
	colliding_areas.push_front(area) 
	check_deal_damage()

func _on_invul_time_timeout():
	check_deal_damage()
