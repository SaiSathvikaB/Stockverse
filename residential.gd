extends Node2D

# Preload textures
var grass_tex = preload("res://assets/tiles/grass.png")
var stonepath_tex = preload("res://assets/tiles/stonepath.png")
var b1_tex = preload("res://assets/buildings/build2.png")
var b2_tex = preload("res://assets/buildings/build2.png")
var b3_tex = preload("res://assets/buildings/cafe.png")
var b4_tex = preload("res://assets/buildings/cart.png")
var b5_tex = preload("res://assets/buildings/FireStation.png")

var b7_tex = preload("res://assets/buildings/house6.png")
var b8_tex = preload("res://assets/buildings/house7.png")
var ic_tex = preload("res://assets/buildings/icecream.png")
var hospital_tex = preload("res://assets/buildings/hospital.png")
var hospital2_tex = preload("res://assets/buildings/hospital2.png")
var police_tex = preload("res://assets/buildings/policestation.png")
var tree_tex = preload("res://assets/buildings/tree.png")
var bush_tex = preload("res://assets/buildings/bush.png")
func place_trees_and_bushes():
	var dots = [


	# Top-right (near tan building and houses)
	Vector2(1270, 50),Vector2(1270, 100),
	Vector2(1270, 200),
	Vector2(1270, 150),
	Vector2(1270, 250),
	
	
	Vector2(1050, 50),Vector2(1050, 100),
	Vector2(1050, 200),
	Vector2(1050, 150),
	Vector2(1050, 250),	Vector2(1000, 50),	Vector2(950, 50),	Vector2(900, 50),Vector2(850, 50),Vector2(800, 50),
	Vector2(1000, 80),	Vector2(950, 80),	Vector2(900, 80),Vector2(850, 80),Vector2(800, 80),

	#police station
Vector2(820,600),
	Vector2(820, 450),
	Vector2(820, 400),
	Vector2(820, 650),Vector2(820, 350),
	
	Vector2(1450,600),
	Vector2(1450, 450),
	Vector2(1450, 400),
	Vector2(1450, 500),
	Vector2(1450, 550),
	Vector2(1450, 650),Vector2(1450, 350),
	
	
	
	#hospital
	Vector2(100, 270),
	Vector2(50, 270),
	Vector2(150, 270),
	Vector2(200, 270),
	Vector2(250, 270),
	Vector2(550, 270),
	Vector2(450, 270),
	Vector2(500, 270),
	Vector2(600, 270),Vector2(650, 270),
	Vector2(700, 270),
	
	
	
]

	for i in range(dots.size()):
		
		place_sprite(tree_tex, dots[i])

func _ready():
	print("level0 ready running")
	# Background grass
	for x in range(0, 1500, 19):
		for y in range(0, 700, 22):
			place_sprite(grass_tex, Vector2(x, y))

	# Stone paths
	for x in range(0, 1500, 48):
		place_sprite(stonepath_tex, Vector2(x, 330))
	for y in range(0, 700, 48):
		var s = Sprite2D.new()
		s.texture = stonepath_tex
		s.position = Vector2(750, y)
		s.rotation_degrees = 90
		add_child(s)

	# === TOP LEFT: Hospital2, Hospital ===
	place_sprite(hospital2_tex, Vector2(350, 150))
	place_sprite(b1_tex, Vector2(900, 200))

	# === TOP RIGHT: Houses (5, 6, 7) ===
	
	place_sprite(b7_tex, Vector2(1150, 50)) # House6
	place_sprite(b7_tex, Vector2(1150, 150)) # House6
	place_sprite(b7_tex, Vector2(1150, 250)) # House6
	place_sprite(b8_tex, Vector2(1400, 50)) # House6
	place_sprite(b8_tex, Vector2(1400, 150)) # House6
	place_sprite(b8_tex, Vector2(1400, 250)) # House6

	# === BOTTOM LEFT: Cart, Ice Cream, Cafe, Hotel ===
	place_sprite(b4_tex, Vector2(50, 550))   # Cart
	place_sprite(ic_tex, Vector2(150, 650))   # Ice Cream
	place_sprite(b3_tex, Vector2(200, 450))   # Cafe
	place_sprite(b5_tex, Vector2(500, 500))   # firestation

	# === BOTTOM RIGHT: Police Station ===
	place_sprite(police_tex, Vector2(1100, 500))
	# Call to add trees & bushes along stone path (your black dot locations)
	place_trees_and_bushes()


func place_sprite(texture, pos):
	var s = Sprite2D.new()
	s.texture = texture
	s.position = pos
	add_child(s)
