class_name Player extends CharacterBody2D

signal update_hud_hp

@export var stats_component : StatsComponent
@export var accel : float = 25.0
@export var turn_velocity : float = 3.0

var attract := false
var center_gravity = null
var is_jumping : bool = false

var scene_width = 600 
var scene_height = 1050

@onready var animation = $AnimationPlayer

func _ready():
	GameEvents.player_ready.emit()

func player_inputs(delta):
	if Input.is_action_pressed("left"):
		rotation -= turn_velocity * delta
	if Input.is_action_pressed("right"):
		rotation += turn_velocity * delta
	
	if Input.is_action_just_pressed("jump"):
		is_jumping = true
		animation.play("jump")
		
	elif Input.is_action_just_released("cancel"):
		GameEvents.emit_remove_portals()

func _physics_process(delta):
	#print(center_gravity)
	#print(stats_component.hp)
	
	var direction = Vector2.RIGHT.rotated(rotation)
	
	velocity.x = move_toward(velocity.x, stats_component.spd * direction.x, accel)
	velocity.y = move_toward(velocity.y, stats_component.spd * direction.y, accel)
	
	if is_jumping == true:
		move_and_slide()
		check_boundaries()
		return
	
	if attract == true and center_gravity != null:
		position.x = move_toward(self.global_position.x, center_gravity.x, 1.1)
		position.y = move_toward(self.global_position.y, center_gravity.y, 1.1)
	
	player_inputs(delta)
	move_and_slide()
	
	check_boundaries()
	
func check_boundaries():
	if position.x <= 0 or position.x >= scene_width:
		velocity.x = -velocity.x
		rotation = PI - rotation

	if position.y <= 0 or position.y >= scene_height:
		velocity.y = -velocity.y
		rotation = -rotation

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "jump":
		is_jumping = false
		animation.play("idle")

func _on_health_component_died():
	GameEvents.emit_game_over()
	get_tree().paused = true

func _on_hurtbox_component_damage_animation_signal():
	emit_signal("update_hud_hp")
	animation.play("damage")
