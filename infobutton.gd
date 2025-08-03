extends Button

# Path to your ChatGPTPopup scene (adjust path as needed)
const CHATGPT_POPUP_SCENE_PATH := "res://chatgptpopup.tscn"

# Your OpenAI API key here or you can export it too
@export var openai_api_key : String = "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"

var chatgpt_popup_scene : PackedScene = preload(CHATGPT_POPUP_SCENE_PATH)

func _ready():
	text = "Info"
	custom_minimum_size = Vector2(120, 50)
	connect("pressed", Callable(self, "_on_pressed"))

func _on_pressed():

	var popup = chatgpt_popup_scene.instantiate()
	popup.openai_api_key = openai_api_key
	get_tree().current_scene.add_child(popup)
	popup.fetch_stock_info()
