extends Area2D

# FIXME: YOU SHOULDNT BE CAPABLE OF CREATING BLACK HOLES INSIDE THEM

func _on_body_entered(body):
	body.attract = true
	body.center_gravity = self.global_position

func _on_body_exited(body):
	body.attract = false
	body.center_gravity = null
