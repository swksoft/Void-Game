class_name Item extends Area2D

# TODO: SOLO SE PUEDE OBTENER ITEMS MEDIANTE AGUJERO NEGRO

func get_item():
	queue_free()

func _on_area_entered(area):
	get_item()
