class_name BasicEnemy extends CharacterBody2D

@export var wave_spawned : bool = false
@export var stats_component : StatsComponent
@export var health_component : HealthComponent

var attract := false
var center_gravity = null

# COMPORTAMIENTO DESEADO
# 1) APARECER EN ESCENA (CHASE)
# 2) SEGUIR AL JUGADOR CON CIERTO RETARDO
# 3) PASADO UNA CANTIDAD RANDOM DE TIEMPO, SE QUEDARÁ QUIETO UNA CANTIDAD ALEATORIA DE TIEMPO, PARA LUEGO SEGUIR PERSIGUIENDO

func behavior(delta):
	var player = get_tree().get_first_node_in_group("Player") as Player
	
	if player == null:
		return
	
	#velocity.x = move_toward(velocity.x, player.global_position.x, stats_component.max_spd * delta)
	#velocity.y = move_toward(velocity.y, player.global_position.y, stats_component.max_spd * delta)
	#velocity = velocity.move_toward(player.global_position, stats_component.spd * delta)
	if attract != true:
		pass
		#position = position.move_toward(player.global_position, stats_component.max_spd * delta)
		#velocity = velocity.move_toward(player.global_position.normalized(), stats_component.spd * delta)

func _physics_process(delta):
	behavior(delta)
	
	if attract == true and center_gravity != null:
		position.x = move_toward(self.global_position.x, center_gravity.x, 1.1)
		position.y = move_toward(self.global_position.y, center_gravity.y, 1.1)
		
	move_and_slide()

func _on_health_component_died():
	GameEvents.emit_enemy_died(wave_spawned)
	queue_free()
