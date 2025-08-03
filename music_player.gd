extends AudioStreamPlayer2D

func _ready():
	connect("finished", Callable(self, "_on_loop_sound").bind(self))
	play()

func _on_loop_sound(player):
	player.play()
