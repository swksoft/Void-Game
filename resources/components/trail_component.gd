extends Line2D

# TODO: DEBE ESTAR MOVIENDOSE SIEMPRE EL JUGADOR SI NO SE BUGEA
# TODO: SE DEBE CONSUMIR MAS RAPIDO A MEDIDA QUE PASA EL TIEMPO

@export var MAX_LENGHT : int

var queue : Array
var delete_points : bool = false
var time_out : bool

@onready var base_scene = get_parent()
@onready var delay = $Delay

func _process(delta):
	var current_pos = base_scene.global_position
	
	queue.push_front(current_pos)
	
	if queue.size() > MAX_LENGHT and !delete_points == false and time_out:
		queue.pop_back()
		time_out = false

	clear_points()

	for point in queue:
		add_point(point)

func _on_start_deleting_timeout():
	delete_points = true

func _on_delay_timeout():
	time_out = true
