extends CharacterBody2D

@export var npc_name = "Neighbour"

var player_in_area = false

var dialogue_data = {
	"name": "Neighbour",
	"dialogues": [
		{"text": "Hey there! Not many people visit this side of Valemont.I used to be a banker, you know. Markets were my playground.
		So tell me, what do you think a stock is?",
		"options": { 
			"A": "A fruit in the market",
			"B": "A share of a company",
			"C": "A digital coin"
			},
		"correct": "B",
		"feedback": {
				"A": "Hmm, not quite. Stocks aren't fruits!",
				"B": "Correct! You’ve got the basics right.",
				"C": "Nope, that's more like crypto."
			},
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
