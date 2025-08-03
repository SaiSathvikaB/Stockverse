extends Button

func _ready():

	self.pressed.connect(self._on_Button_pressed)


func _on_Button_pressed():
	var game1_path = "C:/Users/hp/Desktop/stockverse/stock.exe"
	OS.execute(game1_path, [], [], false)
