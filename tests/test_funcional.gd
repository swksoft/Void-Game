extends Node2D

var previous_line_points = []

@onready var trail_line = $Player/TrailComponent
@onready var camera_2d = $Camera2D
@onready var player = $Player

func _process(delta):
	camera_2d.position = player.global_position
	
	var current_line_points = [global_position]  # Agrega el punto actual del nodo como el primer punto de la línea
	
	#print(current_line_points)
	
	current_line_points.append_array(previous_line_points)  # Agrega los puntos anteriores de la línea
	trail_line.points = current_line_points

	if previous_line_points.size() > 1:
		for i in range(1, current_line_points.size() - 1):
			var segment_start = current_line_points[i - 1]
			var segment_end = current_line_points[i]
			var intersection = get_intersection(segment_start, segment_end, previous_line_points[-1], previous_line_points[-2])
			if intersection:
				create_circle(intersection)

	# Actualiza los puntos anteriores de la línea
	previous_line_points = current_line_points

func get_intersection(point1, point2, point3, point4):
	# Implementa la lógica para detectar la intersección entre dos segmentos de línea
	# Devuelve el punto de intersección si existe, o null si no hay intersección
	# Puedes utilizar algoritmos como el algoritmo de intersección de líneas de Möller–Trumbore o el método de eliminación de bordes (Weiler–Atherton)
	pass

func create_circle(position):
	# Crea un círculo en la posición especificada
	var circle = CircleShape2D.new()
	var circle_node = Node2D.new()
	var circle_sprite = Sprite2D.new()
	circle_sprite.shape = circle
	circle_node.add_child(circle_sprite)
	circle_node.position = position
	add_child(circle_node)
