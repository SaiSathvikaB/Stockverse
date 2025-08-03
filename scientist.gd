extends CharacterBody2D
@export var npc_name = "Scientist"

var player_in_area = false

var dialogue_data = {
	"name": "Scientist",
	"dialogues": [
		{
			"text": "Greetings! I analyze data patterns for fun.\nTell me, which factor can significantly influence stock prices?",
			"options": {
				"A": "Moon phases",
				"B": "Company earnings reports",
				"C": "Favorite color of the CEO"
			},
			"correct": "B",
			"feedback": {
				"A": "Interesting theory, but moon phases don’t drive markets.",
				"B": "Absolutely! Earnings reports directly impact investor decisions.",
				"C": "Funny, but no – that’s not relevant to investors."
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
