extends Area2D

@onready var marker = $Marker


func _on_body_entered(body):
	
	
	#body.marker_2d.position = self.global_position # FIXME: AQUI NO
	body.attract = true
	body.center_gravity = marker.global_position


func _on_body_exited(body):
	body.attract = false
	body.center_gravity = null
