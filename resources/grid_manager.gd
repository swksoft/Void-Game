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
	#icon.centered = false
	icon.z_index = 1
	get_parent().add_child(icon)

func _process(delta):
	# POSITION ON MAP
	var grid_x = round(player.global_position.x / grid_size) * grid_size
	var grid_y = round(player.global_position.y / grid_size) * grid_size
	
	# Verificar si la coordenada de la cuadrícula actual es diferente a la anterior
	var current_grid_coord = Vector2(grid_x, grid_y)
	
	if current_grid_coord != previous_grid_coord:
		previous_grid_coord = current_grid_coord
		
		# POSITION ON GRID
		var relative_x = int(player.global_position.x / grid_size)
		var relative_y = int(player.global_position.y / grid_size)
		
		var new_aux = Vector2(relative_x, relative_y)
		
		if set_grind.has(new_aux):
			print("Interpijación!")
		else:
			set_grind.push_back(new_aux)

		# DEBUG
		spawn_texture(grid_x, grid_y)
		
		print("Cuadrícula: (" + str(grid_x) + ", " + str(grid_y) + ") | Posición relativa: (" + str(relative_x) + ", " + str(relative_y) + ")")
		#print(set_grind, "\n")
