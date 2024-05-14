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
	
	# Verificar si la coordenada de la cuadrícula actual es diferente a la anterior
	
	# POSITION ON GRID
	var relative_x = int(player.global_position.x / grid_size)
	var relative_y = int(player.global_position.y / grid_size)
	
	var current_grid_coord = Vector2(relative_x, relative_y)
	
	if current_grid_coord != previous_grid_coord:
		previous_grid_coord = current_grid_coord
		
		var new_aux = Vector2(relative_x, relative_y)
		
		if set_grind.has(new_aux):
			intersection_point = new_aux
			var res = get_path_to_intersection(set_grind, intersection_point, head)
		
			print("RESULTADO FINAL: ", res)
			
			#delete_all(set_grind)
		else:
			set_grind.push_back(new_aux)
			head = new_aux
			

		# DEBUG
		spawn_texture(grid_x, grid_y)
		
		#print("Cuadrícula: (" + str(grid_x) + ", " + str(grid_y) + ") | Posición relativa: (" + str(relative_x) + ", " + str(relative_y) + ")")
		print(set_grind, "\n")

func get_path_to_intersection(points: Array, intersection_point: Vector2, head: Vector2) -> Array:
	var path = []
	var head_index = points.find(head)

	# Si no se encuentra la cabeza en el array de puntos, regresar un array vacío
	if head_index == -1:
		return path

	var intersection_index = -1

	# Buscar el punto de intersección después de la cabeza
	for i in range(head_index + 1, points.size()):
		if points[i] == intersection_point:
			intersection_index = i
			break

	# Si no se encuentra el punto de intersección después de la cabeza, buscar antes de la cabeza
	if intersection_index == -1:
		for i in range(head_index):
			if points[i] == intersection_point:
				intersection_index = i
				break

	# Si todavía no se encuentra el punto de intersección, regresar un array vacío
	if intersection_index == -1:
		return path

	# Construir el subarray que va desde la cabeza hasta el punto de intersección
	if head_index < intersection_index:
		path = points.slice(head_index, intersection_index + 1)
	else:
		path = points.slice(head_index, points.size()) + points.slice(0, intersection_index + 1)

	return path


func delete_all(array : Array):
	array.clear()
	
	var node = get_parent().get_node("DebugIcon")
	
	for i in node.get_children():
		i.queue_free()
