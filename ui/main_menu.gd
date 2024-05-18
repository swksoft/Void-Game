extends Control

@onready var button = $CenterContainer/VBoxContainer/Button

func _ready():
	button.grab_focus()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://tests/test_funcional.tscn")
