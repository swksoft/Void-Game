extends Line2D

func trace_line():
	var pos = get_global_mouse_position()
	add_point(pos)

func _process(delta):
	trace_line()
	
