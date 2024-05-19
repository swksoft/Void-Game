extends HitboxComponent 

# FIXME: YOU SHOULDNT BE CAPABLE OF CREATING BLACK HOLES INSIDE THEM

var attraction_strength = 300 
var stats_component : StatsComponent
var player : Player

func _ready():
	is_blackhole = true
	
	print(is_in_group("BlackHole"))
	
	attacker = player
	GameEvents.player_ready.connect(on_player_ready)

func _on_body_entered(body):
	body.attract = true
	body.center_gravity = global_position - body.position
	
	_apply_attraction(body)

func _on_body_exited(body):
	body.attract = false
	body.center_gravity = null

func _apply_attraction(body):
	pass
	#var center = global_position
	#var body_pos = body.global_position
	#var direction = center - body_pos
	#var distance = direction.length()
	#
	#if distance > 0:
		#var force_magnitude = attraction_strength / distance
		#var attraction_force = direction.normalized() * force_magnitude
		##body.attraction_force = attraction_force

func on_player_ready():
	stats_component = get_tree().get_first_node_in_group("Player").get_node("StatsComponent")

