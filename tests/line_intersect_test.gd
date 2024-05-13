extends Node2D

@onready var line_2d = $Line2D
@onready var marker = $Marker2D

func _ready():
	var points = line_2d.get_points()
	#print(points)
	
	
	
	#line_2d.get_point_position()
	#var path = PolygonPathFinder.new()
	
	
	
	
	# SEGMENT TO SEGMENT
	#var res_path = path.get_intersections(line_2d.points[0], line_2d.points[-1])
	#print(res_path)
	#var intersection = Geometry2D.segment_intersects_segment(
		#line_2d.to_global(line_2d.points[0]),
		#line_2d.to_global(line_2d.points[1]),
		#line_2d.to_global(line_2d.points[4]),
		#line_2d.to_global(line_2d.points[5]))
	#marker.global_position = intersection
	#prints(intersection)

