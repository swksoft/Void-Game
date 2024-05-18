class_name HealthComponent extends Node

signal died

#func damage(incoming_damage: float):
	#stats_component.health -= final_damage
	#changed.emit()
	#if get_parent().is_in_group("Enemy"):
		#GameEvents.emit_enemy_hit(get_parent())
		#if final_damage > 0:
			#var floating_text = floating_text_scene.instantiate() as Node2D
			#get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)
			#floating_text.global_position = get_parent().global_position
			#floating_text.start(str(final_damage))
	#Callable(check_death).call_deferred()
