extends Node

var wave = 0

signal wave_start(wave : int)
signal wave_end(wave : int)
signal wave_enemy_spawned
signal wave_enemy_limit_reached
signal enemy_died(wave_spawned: bool)
signal stat_update
signal enemy_hit(enemy: BasicEnemy)
signal player_ready(player: Player)


func emit_wave_start():
	wave_start.emit(wave)
	
func emit_wave_end():
	wave_end.emit(wave)

func emit_enemy_died(wave_spawned: bool):
	enemy_died.emit(wave_spawned)

func emit_wave_enemy_limit_reached():
	wave_enemy_limit_reached.emit()

func emit_stat_update():
	stat_update.emit()

func emit_enemy_hit(enemy: BasicEnemy):
	enemy_hit.emit(enemy)

func emit_player_ready():
	player_ready.emit()
