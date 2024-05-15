extends CanvasLayer

# TODO: ADD SCORE

var hp : int
var atk : int

@onready var hp_stat = $Panel/Panel/StatContainer/HPstat
@onready var atk_stat = $Panel/Panel/StatContainer/ATKstat
@onready var rng_stat = $Panel/Panel/StatContainer/RNGstat
@onready var dly_stat = $Panel/Panel/StatContainer/DLYstat
@onready var dps_stat = $Panel/Panel/StatContainer/DPSstat
@onready var abr_stat = $Panel/Panel/StatContainer/ABRstat
@onready var qty_stat = $Panel/Panel/StatContainer/QTYstat
@onready var spd_stat = $Panel/Panel/StatContainer/SPDstat

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
