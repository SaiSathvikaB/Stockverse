extends Control

@onready var music_toggle = $HBoxContainer/music      # CheckButton node
@onready var back_button = $HBoxContainer/back        # Back Button node

func _ready():
	var music_player = get_node("/root/musicstockverse")  # Get the global autoloaded MusicPlayer
	if music_player:
		music_toggle.button_pressed = music_player.playing
	else:
		print("Global MusicPlayer not found!")

	music_toggle.connect("toggled", _on_music_toggled)
	back_button.connect("pressed", _on_back_pressed)

func _on_music_toggled(button_pressed):
	var music_player = get_node("/root/musicstockverse")
	if music_player:
		if button_pressed:
			music_player.play()
		else:
			music_player.stop()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://mainscreen.tscn")
