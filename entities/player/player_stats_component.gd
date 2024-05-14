extends StatsComponent

@export var max_atk := 5.0
@export var max_rng := 7.0
@export var max_dly := 3.2
@export var max_dps := 2.0
@export var max_abr := 10.0
@export var max_qty := 3

var atk : float
var rng : float
var dly : float
var dps : float
var abr : float
var qty : float

func _ready():
	super._ready()
	atk = max_atk
	rng = max_rng
	dly = max_dly
	dps = max_dps
	abr = max_abr
	qty = max_qty
