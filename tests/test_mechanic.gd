extends Node2D

@onready var line = $DrawLinesTest

func _ready():
	$CollisionShape2D.shape.points = [Vector2(104, 56), Vector2(272.075, 120), Vector2(184, 200), Vector2(112, 176), Vector2(168.11, 144), Vector2(208.015, 56)]
	
func _process(delta):
	pass
	#$CollisionShape2D.shape.points = [Vector2(104, 56), Vector2(272.075, 120), Vector2(184, 200), Vector2(112, 176), Vector2(168.11, 144), Vector2(208.015, 56)]
	#var intersection = Geometry2D.get_closest_point_to_segment($NearestPoint.global_position, )
