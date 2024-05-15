class_name Player extends CharacterBody2D

@export var stats_component : StatsComponent
@export var accel : float = 25.0

# TODO: Turn velocity

func _ready():
	GameEvents.emit_player_ready()

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	
	velocity.x = move_toward(velocity.x, stats_component.spd * direction.x, accel)
	velocity.y = move_toward(velocity.y, stats_component.spd * direction.y, accel)
	
	if Input.is_action_pressed("left"):
		rotation -= 3 * delta
	elif Input.is_action_pressed("right"):
		rotation += 3 * delta
		
	# TODO: JUMP (MAKE SPRITE LARGER AND DISABLE COLLISION) (REPRODUCIR ANIMACION)
	if Input.is_action_just_pressed("jump"):
		pass
		
	move_and_slide()
