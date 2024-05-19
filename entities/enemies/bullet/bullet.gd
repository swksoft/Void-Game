extends HitboxComponent

@export var speed = 150

var direction : Vector2

@onready var despawn_timer = $DespawnTimer

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	queue_free()

func _on_despawn_timer_timeout():
	queue_free()
