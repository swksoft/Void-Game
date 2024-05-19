extends Node2D

var wave_enemies = 20
var remaining
var spawned = 0

@onready var timer = $Timer

var enemy_normal = preload("res://entities/enemies/enemy_base.tscn")
var enemy_types = [enemy_normal]

@onready var spawn_path = $SpawnPath/EnemyPawn

func _ready():
	spawn()
	
	GameEvents.enemy_died.connect(on_enemy_died)
	GameEvents.wave_enemy_spawned.connect(on_wave_enemy_spawned)
	timer.start()

func get_remaining_time():
	return timer.time_left

#func wave_start():
	#GameEvents.wave_limit = false
	#spawned = 0
	#remaining = wave_enemies
	#GameEvents.wave += 1
	#GameEvents.emit_wave_start()
	#GameEvents.wave_in_course = true
	
func wave_end():
	GameEvents.emit_wave_end()
	timer.start()

func spawn():
	#var spawn_position = spawn_path.progress_ratio(randi())
	spawn_path.progress_ratio = randf()
	#spawn_path.offset = random_offset
	var spawn_position = spawn_path.position
	
	var enemy_spawn = enemy_types[randi() % enemy_types.size()] # TODO: Curve2D
	var selected = enemy_spawn.instantiate()
	
	selected.position = spawn_position
	
	#get_parent().add_child(selected)
	get_parent().add_child.call_deferred(selected)

func _on_timer_timeout():
	spawn()
	#timer.stop()
	#wave_start()

func on_enemy_died(wave_spawned: bool):
	if wave_spawned:
		remaining -= 1
		if remaining <= 0:
			wave_end()
			
func on_wave_enemy_spawned():
	spawned += 1
	if spawned >= wave_enemies:
		GameEvents.emit_wave_enemy_limit_reached()
		GameEvents.wave_limit = true
