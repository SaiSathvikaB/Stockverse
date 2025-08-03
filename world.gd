extends Node2D

@onready var current_map_holder = $CurrentMap
@onready var player = $player

# Define all transition rules, use "spawn" to indicate spawn point names (Position2D node names)
var map_transitions = {
	"residential": {
		"rightexit": {"scene": "res://downtown_1.tscn", "spawn": "LeftSpawn", "map": "downtown"},
		"leftexit":  {"scene": "res://beach.tscn", "spawn": "RightSpawn", "map": "beach"},
		"topexit":    {"scene": "res://industry.tscn", "spawn": "BottomSpawn", "map": "industry"},
		"bottomexit":  {"scene": "res://garden.tscn", "spawn": "TopSpawn", "map": "garden"},
	},
	"beach": {
		"topexit":   {"scene": "res://industry.tscn", "spawn": "BottomSpawn", "map": "industry"},
		"bottomexit": {"scene": "res://garden.tscn", "spawn": "TopSpawn", "map": "garden"},
		"rightexit": {"scene": "res://residential.tscn", "spawn": "LeftSpawn", "map": "residential"}
	},
	"downtown": {
		"topexit":   {"scene": "res://residential.tscn", "spawn": "BottomSpawn", "map": "residential"},
		"bottomexit": {"scene": "res://garden.tscn", "spawn": "TopSpawn", "map": "garden"},
		"leftexit": {"scene": "res://residential.tscn", "spawn": "RightSpawn", "map": "residential"}
	},
	"industry": {
		"bottomexit": {"scene": "res://residential.tscn", "spawn": "TopSpawn", "map": "residential"},
		"leftexit": {"scene": "res://beach.tscn", "spawn": "RightSpawn", "map": "beach"},
	},
	"garden": {
		"topexit": {"scene": "res://residential.tscn", "spawn": "BottomSpawn", "map": "residential"},
		"leftexit": {"scene": "res://beach.tscn", "spawn": "RightSpawn", "map": "beach"},
		"rightexit": {"scene": "res://downtown_1.tscn", "spawn": "LeftSpawn", "map": "downtown"}
	}
}

var current_map_name = "residential"
var current_map_instance: Node2D = null

func _ready():
	load_map("res://residential.tscn")
	
	# For the very first spawn on residential map, use a default spawn
	var default_spawn = current_map_instance.get_node_or_null("RightSpawn")  # or LeftSpawn, your choice
	if default_spawn:
		player.global_position = default_spawn.global_position
	else:
		player.position = Vector2(750, 300)  # fallback

func load_map(scene_path: String):
	# Clear previous map
	if current_map_instance:
		current_map_instance.queue_free()

	# Load and add new map
	var map_scene = load(scene_path)
	current_map_instance = map_scene.instantiate()
	current_map_holder.add_child(current_map_instance)

	# Connect border signals if any (Area2D for exits)
	for area in current_map_instance.get_children():
		if area is Area2D:
			area.body_entered.connect(_on_area_entered.bind(area.name))

func _on_area_entered(body, direction):
	if body != player:
		return

	direction = direction.to_lower()

	if direction in map_transitions[current_map_name]:
		var transition = map_transitions[current_map_name][direction]
		call_deferred("_deferred_transition", transition)

func _deferred_transition(transition: Dictionary) -> void:
	current_map_name = transition["map"]
	load_map(transition["scene"])
	
	var spawn_name = transition.get("spawn", "")
	var spawn_point = current_map_instance.get_node_or_null(spawn_name)
	
	if spawn_point:
		player.global_position = spawn_point.global_position
	else:
		push_warning("Spawn point not found: " + spawn_name)
