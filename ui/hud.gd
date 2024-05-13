extends CanvasLayer

# TODO: ADD SCORE

var hp : int
var atk : int

@onready var hp_stat = $Panel/Panel/GridContainer/HPstat
@onready var atk_stat = $Panel/Panel/GridContainer/ATKstat
@onready var rng_stat = $Panel/Panel/GridContainer/RNGstat
@onready var dly_stat = $Panel/Panel/GridContainer/DLYstat
@onready var dps_stat = $Panel/Panel/GridContainer/DPSstat
@onready var abr_stat = $Panel/Panel/GridContainer/ABRstat
@onready var qty_stat = $Panel/Panel/GridContainer/QTYstat
@onready var spd_stat = $Panel/Panel/GridContainer/SPDstat

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
