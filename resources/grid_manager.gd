extends Node2D

signal get_center_signal(coordinates)

@export var map_path : NodePath
@export var player_path : NodePath
@export var texture_path : CompressedTexture2D
@export var hole_sprite_scene : PackedScene

var trail_paths = [
	load("res://assets/textures/trail25x25_1.png"),
	load("res://assets/textures/trail25x25_2.png"),
	load("res://assets/textures/trail25x25_3.png"),
	load("res://assets/textures/trail25x25_4.png"),
	load("res://assets/textures/trail25x25_5.png")]

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
@onready var black_hole_area = $BlackHole

func _ready():
	GameEvents.remove_portals.connect(on_remove_portals)

func spawn_texture(x, y):
	var pos = Vector2(x, y)
	var icon = Sprite2D.new()
	#icon.texture = texture_path
	icon.texture = trail_paths.pick_random()
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
	
	if current_grid_coord != previous_grid_coord:
		previous_grid_coord = current_grid_coord
		
		var new_aux = Vector2(relative_x, relative_y)
		
		if set_grind.has(new_aux):
			intersection_point = new_aux
			
			show_result()
			
			delete_all(set_grind)
		else:
			set_grind.push_back(new_aux)
			
			head = new_aux
			
			spawn_texture(grid_x, grid_y)

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
	var bottom_right = Vector2(max_x, max_y)
	
	return Rect2(top_left, Vector2(width, height))

func create_collision_shape(rect: Rect2) -> CollisionShape2D:
	var collision_shape = CollisionShape2D.new()
	var rectangle_shape = RectangleShape2D.new()
	
	rectangle_shape.extents = rect.size / 2
	collision_shape.shape = rectangle_shape
	collision_shape.position = rect.size / 2
	
	return collision_shape

func get_segment_to_intersection(head: Vector2, path: Array, intersection: Vector2) -> Array:
	var segment = []

	var intersection_index = path.find(intersection)
	
	if intersection_index == -1:
		print("Intersección no encontrada en el path")
		return segment
	
	for i in range(intersection_index, len(path)):
		segment.append(path[i])
		if path[i] == head:
			break
	
	if segment.size() <= 7:
		segment = []
		return segment
	
	print_debug(segment.size())
	
	return segment

func delete_all(array : Array):
	array.clear()
	
	var node = get_parent().get_node("DebugIcon")
	
	for i in node.get_children():
		i.queue_free()

func show_result():
	var res = get_segment_to_intersection(head, set_grind, intersection_point)
	
	if res == []:
		return
	
	var create_box = calculate_bounding_box(res)
	var collision_shape = create_collision_shape(create_box)
	
	var hole_sprite = hole_sprite_scene.instantiate()
	
	emit_signal("get_center_signal", create_box.position * 25 + create_box.size / 2)
	
	collision_shape.position = create_box.position * 25 + create_box.size / 2  
	hole_sprite.position = collision_shape.global_position
	
	black_hole_area.add_child(collision_shape)
	black_hole_area.add_child(hole_sprite)

func on_remove_portals():
	if black_hole_area.get_children().size() == 0: return
	
	var children = black_hole_area.get_children()
	
	for i in children:
		i.queue_free()
		
