class_name HealthComponent extends Node

signal died
signal changed

@export var stats_component : StatsComponent

func _ready():
	changed.emit()

func damage(incoming_damage: float):
	var final_damage = incoming_damage
	
	stats_component.hp -= final_damage
	
	changed.emit()
	
	if get_parent().is_in_group("Enemy"):
		GameEvents.emit_enemy_hit(get_parent())

	elif get_parent().is_in_group("Player"):
		GameEvents.emit_player_hit(get_parent())
	Callable(check_death).call_deferred()

func check_death():
	if stats_component.hp <= 0: died.emit()

func set_hp(new_hp: float):
	stats_component.hp = new_hp
	changed.emit()
