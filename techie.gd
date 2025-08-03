extends CharacterBody2D
@export var npc_name = "Techie"

var player_in_area = false

var dialogue_data = {
	"name": "Techie",
	"dialogues": [
		{
			"text": "Hey! I’ve been developing an app to track stock trends.\nDo you know what an IPO is?",
			"options": {
				"A": "Initial Public Offering",
				"B": "Internet Protocol Overview",
				"C": "Investment Portfolio Order"
			},
			"correct": "A",
			"feedback": {
				"A": "Correct! It's when a company first offers its shares to the public.",
				"B": "Nope, that’s a tech term unrelated to finance.",
				"C": "Not quite. That’s not what IPO stands for."
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
