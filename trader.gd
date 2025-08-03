extends CharacterBody2D
@export var npc_name = "TraderGirl"

var player_in_area = false

var dialogue_data = {
	"name": "Investor",
	"dialogues": [
		{
			"text": "Hey! I just made a neat profit on a trade. Quick question:\nWhat does it mean when a stock is ‘bullish’?",
			"options": {
				"A": "It's going down in price",
				"B": "It's stable with no change",
				"C": "It's expected to rise in price"
			},
			"correct": "C",
			"feedback": {
				"A": "Nope! That would be bearish.",
				"B": "Not quite. Bullish implies growth, not flat movement.",
				"C": "Correct! Bullish means it's likely going up."
			}
		}
	]
}



func _ready():
	$AnimatedSprite2D.play("idle")
	$ChatArea.connect("body_entered", Callable(self, "_on_body_entered"))
	$ChatArea.connect("body_exited", Callable(self, "_on_body_exited"))



func _on_body_entered(body):
	if body.name == "player":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "player":
		player_in_area = false
		DialogueManager.reset_state()


func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("ui_accept"):
		if not DialogueManager.visible:  # Only trigger if not already showing
			print("Player pressed Enter near NPC")
			DialogueManager.reset_state()  # Ensure clean state every time
			DialogueManager.load_dialogue(dialogue_data)
			DialogueManager.show()
