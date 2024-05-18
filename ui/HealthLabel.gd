extends Node

var stats_component : StatsComponent

func _ready():
	on_player_ready()

func update():
	self.text = str(stats_component["hp"])
	
func on_player_ready():
	stats_component = get_tree().get_first_node_in_group("Player").get_node("StatsComponent")
	GameEvents.stat_update.connect(update)
	update()
