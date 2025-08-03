extends Node2D

var neighbour_scene = preload("res://neighbour.tscn")

var grass_tex = preload("res://assets/tiles/grass.png")
var stonepath_tex = preload("res://assets/tiles/stonepath.png")
var b1_tex = preload("res://assets/buildings/build2residential-removebg-preview.png")
var b3_tex = preload("res://assets/buildings/cafe.png")
var b4_tex = preload("res://assets/buildings/cart.png")
var b5_tex = preload("res://assets/buildings/FireStation.png")
var b7_tex = preload("res://assets/buildings/house6.png")
var b8_tex = preload("res://assets/buildings/house7.png")
var ic_tex = preload("res://assets/buildings/icecream.png")
var hospital2_tex = preload("res://assets/buildings/hospital2.png")
var police_tex = preload("res://assets/buildings/policestation.png")
var tree_tex = preload("res://assets/buildings/tree.png")
var bush_tex = preload("res://assets/buildings/bush.png")
var build_scale=Vector2(1.5,1.5)
func place_trees_and_bushes():
	var dots = [
		Vector2(1270, 50), Vector2(1270, 100), Vector2(1270, 200), Vector2(1270, 150), Vector2(1270, 250),
		Vector2(1050, 50), Vector2(1050, 100), Vector2(1050, 200), Vector2(1050, 150), Vector2(1050, 250),
		Vector2(1000, 50), Vector2(950, 50), Vector2(900, 50), Vector2(850, 50), Vector2(800, 50),
		Vector2(1000, 80), Vector2(950, 80), Vector2(900, 80), Vector2(850, 80), Vector2(800, 80),
		Vector2(820, 600), Vector2(820, 450), Vector2(820, 400), Vector2(820, 650), 
		Vector2(1450, 600), Vector2(1450, 450), Vector2(1450, 400), Vector2(1450, 500), Vector2(1450, 550), Vector2(1450, 650),
		Vector2(100, 270), Vector2(50, 270), Vector2(150, 270), Vector2(200, 270), Vector2(250, 270),
		Vector2(550, 270), Vector2(450, 270), Vector2(500, 270), Vector2(600, 270), Vector2(650, 270), Vector2(700, 270),
	]
	for pos in dots:
		place_static_obstacle(tree_tex, pos, Vector2(64, 64))


func _ready():
	print("level0 ready running")

	# Background grass (no collision)
	for x in range(0, 1500+19, 19):
		for y in range(0, 700+22, 22):
			place_sprite(grass_tex, Vector2(x, y))

	# Stone paths (no collision)
	for x in range(0, 1500, 48):
		place_sprite(stonepath_tex, Vector2(x, 330))
	for y in range(0, 700, 48):
		var s = Sprite2D.new()
		s.texture = stonepath_tex
		s.position = Vector2(750, y)
		s.rotation_degrees = 90
		add_child(s)

	# Buildings (with collision)
	place_static_obstacle(hospital2_tex, Vector2(350, 150), Vector2(128, 128))
	place_static_obstacle(b1_tex, Vector2(900, 200), Vector2(128, 128),build_scale)
	place_static_obstacle(b7_tex, Vector2(1150, 50), Vector2(128, 128))
	place_static_obstacle(b7_tex, Vector2(1150, 150), Vector2(128, 128))
	place_static_obstacle(b7_tex, Vector2(1150, 250), Vector2(128, 128))
	place_static_obstacle(b8_tex, Vector2(1400, 50), Vector2(128, 128))
	place_static_obstacle(b8_tex, Vector2(1400, 150), Vector2(128, 128))
	place_static_obstacle(b8_tex, Vector2(1400, 250), Vector2(128, 128))
	place_static_obstacle(b4_tex, Vector2(50, 550), Vector2(128, 128))
	place_static_obstacle(ic_tex, Vector2(150, 650), Vector2(128, 128))
	place_static_obstacle(b3_tex, Vector2(200, 450), Vector2(128, 128))
	place_static_obstacle(b5_tex, Vector2(500, 500), Vector2(128, 128))
	place_static_obstacle(police_tex, Vector2(1100, 500), Vector2(128, 128))

	# Trees and bushes (with collision)
	place_trees_and_bushes()
	# Add Neighbour NPC
	var neighbour = neighbour_scene.instantiate()
	neighbour.position = Vector2(1350, 650)  # Adjust as needed
	add_child(neighbour)



func place_sprite(texture, pos):
	var s = Sprite2D.new()
	s.texture = texture
	s.position = pos
	add_child(s)

# Helper function to place collision obstacles
func place_static_obstacle(texture, pos, collision_size, scale := Vector2(1, 1)):
	var static_body = StaticBody2D.new()
	static_body.position = pos

	var sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.position = Vector2.ZERO
	sprite.scale = scale  # ✅ Apply scale
	static_body.add_child(sprite)

	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = collision_size / 2  # extents is half-size
	collision.shape = shape
	collision.position = Vector2.ZERO
	static_body.add_child(collision)

	add_child(static_body)
