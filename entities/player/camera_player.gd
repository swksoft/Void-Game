extends Camera2D

@export var player : Player

func _physics_process(delta):
	self.position = player.global_position

