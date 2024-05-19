extends Node

@export var stat_name : String

var stats_component : StatsComponent

func _ready():
	GameEvents.player_ready.connect(on_player_ready) # NO FUNCA
	
	#on_player_ready()

func update():
	self.text = str(stats_component["max_" + stat_name])
	
func on_player_ready():
	stats_component = get_tree().get_first_node_in_group("Player").get_node("StatsComponent")
	GameEvents.stat_update.connect(update)
	update()
