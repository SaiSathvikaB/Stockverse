extends CharacterBody2D

@export var npc_name = "Oldman"

var player_in_area = false

var dialogue_data = {
	"name": "Oldman",
	"dialogues": [
		{
			"text": "Ah, young one! Back in my day, stocks were about trust and patience.\nSo tell me, what is a dividend?",
			"options": { 
				"A": "A company's profit shared with shareholders",
				"B": "A type of stock market crash",
				"C": "An investment scam"
			},
			"correct": "B",
			"feedback": {
				"A": "Correct! Dividends reward shareholders.",
				"B": "No, a crash is something different.",
				"C": "Nope, scams are bad things to avoid."
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
