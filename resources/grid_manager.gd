@icon("res://te-metes-el-dedo-por-el-clitoris.svg")
extends Node2D


@export var map_path : NodePath
@export var player_path : NodePath
@export var texture_path : CompressedTexture2D

# grid variable
var grid_size = 25

# player variables
var head : Vector2 # current position on grid
var tail : Vector2 # last position on grid
var set_grind : Array
var intersection_point : Vector2

# AUX
var previous_grid_coord = Vector2.ZERO

@onready var player = get_node(player_path)
@onready var map = get_node(map_path)

func trace_path():
	pass

func spawn_texture(x, y):
	var pos = Vector2(x, y)
	var icon = Sprite2D.new()
	icon.texture = texture_path
	icon.scale /= 5
	icon.position = pos
	icon.centered = true
	icon.z_index = 0
	get_parent().get_node("DebugIcon").add_child(icon)

func _process(delta):
	# POSITION ON MAP
	var grid_x = round(player.global_position.x / grid_size) * grid_size
	var grid_y = round(player.global_position.y / grid_size) * grid_size
	# POSITION ON GRID
	var relative_x = int(player.global_position.x / grid_size)
	var relative_y = int(player.global_position.y / grid_size)
	
	var current_grid_coord = Vector2(relative_x, relative_y)
	
	# Verificar si la coordenada de la cuadrícula actual es diferente a la anterior
	if current_grid_coord != previous_grid_coord:
		previous_grid_coord = current_grid_coord
		
		var new_aux = Vector2(relative_x, relative_y)
		
		if set_grind.has(new_aux):
			# FIXME : NO SE ESTÁ BORRANDO EL PATH
			intersection_point = new_aux
			
			#print("HEAD: ", head)
			#print("CURRENT PATH: ", set_grind)
			#print("INTERSECTION: ", intersection_point)
			
			var res = get_segment_to_intersection(head, set_grind, intersection_point)
			var create_box = calculate_bounding_box(res)
			var collision_shape = create_collision_shape(create_box)
			
			# Crear un nodo CollisionShape2D y agregarlo a la escena actual
			var collision_node = Node2D.new()
			collision_node.position = create_box.position * 25
			collision_node.add_child(collision_shape)
			add_child(collision_node)
			
			#print("Intersection")
			#print("RESULTADO FINAL: ", res)
			
			delete_all(set_grind)
		else:
			set_grind.push_back(new_aux)
			head = new_aux
			#print(head)

		# DEBUG
		#spawn_texture(grid_x, grid_y)
		
		#print("Cuadrícula: (" + str(grid_x) + ", " + str(grid_y) + ") | Posición relativa: (" + str(relative_x) + ", " + str(relative_y) + ")")
		#print(set_grind, "\n")

func calculate_bounding_box(segment: Array) -> Rect2:
	var multiplier = 25
	
	if segment.size() == 0:
		return Rect2()
	
	var min_x = segment[0].x
	var max_x = segment[0].x
	var min_y = segment[0].y
	var max_y = segment[0].y
	
	for point in segment:
		if point.x < min_x:
			min_x = point.x
		if point.x > max_x:
			max_x = point.x
		if point.y < min_y:
			min_y = point.y
		if point.y > max_y:
			max_y = point.y
	
	var width = (max_x - min_x) * multiplier
	var height = (max_y - min_y) * multiplier
	var top_left = Vector2(min_x, min_y)
	
	return Rect2(top_left, Vector2(width, height))

func create_collision_shape(rect: Rect2) -> CollisionShape2D:
	var collision_shape = CollisionShape2D.new()
	var rectangle_shape = RectangleShape2D.new()
	
	rectangle_shape.extents = rect.size / 2  # La mitad del ancho y largo
	collision_shape.shape = rectangle_shape
	collision_shape.position = rect.position + rect.size / 2  # Centrar el rectángulo
	
	return collision_shape

func get_segment_to_intersection(head: Vector2, path: Array, intersection: Vector2) -> Array:
	var segment = []

	# Encontrar el índice de la intersección en el path
	var intersection_index = path.find(intersection)
	
	# Verificar que la intersección se encuentra en el path
	if intersection_index == -1:
		print("Intersección no encontrada en el path")
		return segment
	
	# Agregar los puntos desde head hasta la intersección (inclusive)
	for i in range(intersection_index, len(path)):
		segment.append(path[i])
		if path[i] == head:
			break
	
	print_debug(segment)
	
	return segment

func delete_all(array : Array):
	array.clear()
	
	var node = get_parent().get_node("DebugIcon")
	
	for i in node.get_children():
		i.queue_free()
