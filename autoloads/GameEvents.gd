extends Node

var wave = 0

signal wave_start(wave : int)
signal wave_end(wave : int)
signal wave_enemy_spawned
signal wave_enemy_limit_reached
signal enemy_died(wave_spawned: bool)
signal stat_update
signal enemy_hit(enemy: BasicEnemy)
signal player_ready
signal remove_portals
signal player_hit
signal game_over

func emit_wave_start():
	print("emit_wave_start")
	wave_start.emit(wave)
	
func emit_wave_end():
	print("emit_wave_end")
	wave_end.emit(wave)

func emit_enemy_died(wave_spawned: bool):
	print("emit_wave_died")
	enemy_died.emit(wave_spawned)

func emit_wave_enemy_limit_reached():
	print("emit_wave_enemy_limit_reached")
	wave_enemy_limit_reached.emit()

func emit_stat_update():
	print("emit_stat_update")
	stat_update.emit()

func emit_enemy_hit(enemy: BasicEnemy):
	enemy_hit.emit(enemy)

func emit_player_ready():
	player_ready.emit()

func emit_remove_portals():
	print("Remove portals")
	remove_portals.emit()

func emit_player_hit(player : Player):
	player_hit.emit(player)

func emit_game_over():
	game_over.emit()
