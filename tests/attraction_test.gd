extends Node2D
@onready var marker_2 = $Marker2

func _process(delta):
	if Input.is_action_just_pressed("cancel"):
		marker_2.queue_free()
