extends CanvasLayer

@onready var menu_button = $openmenu

func _ready():
	menu_button.connect("pressed", self._on_menu_pressed)

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://mainscreen.tscn")  # Adjust path
