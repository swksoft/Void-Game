extends CanvasLayer

# TODO: ADD SCORE

@onready var panel_game_over = $Control/PanelContainer
@onready var health_label = $Control/Panel/PanelHP/GridContainer/HealthLabel

func _ready():
	panel_game_over.visible = false
	GameEvents.game_over.connect(on_game_over)

func _on_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func on_game_over():
	panel_game_over.visible = true

func _on_player_update_hud_hp():
	health_label.update()
	health_label.update()
