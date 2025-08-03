extends Control

func _ready():
	$HBoxContainer/start.pressed.connect(_on_start_pressed)
	$HBoxContainer/settings.pressed.connect(_on_settings_pressed)
	$HBoxContainer/exit.pressed.connect(_on_exit_pressed)


func _on_start_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
	

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://settingsnode.tscn")
 # Path to your Settings scene

func _on_exit_pressed():
	get_tree().quit()
