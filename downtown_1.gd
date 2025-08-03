extends Node2D


var oldman_scene = preload("res://techie.tscn")
# Preload textures
var grass_tex = preload("res://assets/tiles/grass.png")
var stonepath_tex = preload("res://assets/tiles/factorytile4.png")
var road_tex = preload("res://assets/tiles/factorytile1.png")
var tree_tex = preload("res://assets/tiles/dttree2.png")
var tile_tex=preload("res://assets/tiles/stonepath.png")

# Vehicles
var car1_tex = preload("res://assets/buildings/car1-removebg-preview.png")
var truck1_tex = preload("res://assets/buildings/truck1.png")
var truck2_tex = preload("res://assets/buildings/truck2.png")

# Other elements
var traffic_signal_tex = preload("res://assets/buildings/traffic_light-removebg-preview.png")
var tile_size = Vector2(100, 100)
var b1_tex = preload("res://assets/buildings/downtown1.png")
var b2_tex = preload("res://assets/buildings/dt2-removebg-preview.png")
var b3_tex = preload("res://assets/buildings/dt3-removebg-preview.png")
var b4_tex = preload("res://assets/buildings/dt4-removebg-preview.png")
var b5_tex = preload("res://assets/buildings/dt7-removebg-preview.png")
var b6_tex = preload("res://assets/buildings/dt8-removebg-preview.png")
var b7_tex = preload("res://assets/buildings/dt10-removebg-preview.png")
var b8_tex = preload("res://assets/buildings/dt9-removebg-preview.png")

var tilescale = Vector2(2.8, 2.8)
var tilescale2 = Vector2(2.5, 2.5)

func _ready():
	# Add the Player to the scene

	# Fill entire viewport with road tiles
	for x in range(0, 1500, 10):
		for y in range(0, 700, 10):
			place_sprite(road_tex, Vector2(x, y), Vector2(1,1))

	# Stone paths
	for x in range(0, 700, 10):
		for y in range(350, 700, 10):
			place_sprite(stonepath_tex, Vector2(x, y), Vector2(1,1))

	for x in range(1000, 1500, 10):
		for y in range(400, 700, 10):
			place_sprite(stonepath_tex, Vector2(x, y), Vector2(1,1))
	#for factorytile1 for bottom right
	for x in range(1050, 1550, 10):
		for y in range(450, 650, 10):
			place_sprite(tile_tex, Vector2(x, y), Vector2(1,1))
	#for factorytile1 for bottom left
	for x in range(20, 670, 10):
		for y in range(400, 650, 10):
			place_sprite(tile_tex, Vector2(x, y), Vector2(1,1))


	for x in range(1000, 1500, 10):
		for y in range(0, 300, 10):
			place_sprite(stonepath_tex, Vector2(x, y), Vector2(1,1))

	for x in range(1050, 1450, 10):
		for y in range(50, 250, 10):
			place_sprite(grass_tex, Vector2(x, y), Vector2(1,1))

	# Trees
	for y in range(50, 240, 60):
		place_static_obstacle(tree_tex, Vector2(1060, y), tilescale2)
		place_static_obstacle(tree_tex, Vector2(1100, y), tilescale2)
		place_static_obstacle(tree_tex, Vector2(1150, y), tilescale2)
		place_static_obstacle(tree_tex, Vector2(1440, y), tilescale2)

	# Buildings with collision
	place_static_obstacle(b1_tex, Vector2(170,450), tilescale)
	place_static_obstacle(b2_tex, Vector2(360,440), tilescale)
	place_static_obstacle(b3_tex, Vector2(500,450), tilescale)
	place_static_obstacle(b6_tex, Vector2(630,526), tilescale)
	place_static_obstacle(b4_tex, Vector2(1090,450), tilescale)
	place_static_obstacle(b5_tex, Vector2(1300,100), tilescale)
	place_static_obstacle(b7_tex, Vector2(1250,510), tilescale)
	place_static_obstacle(b8_tex, Vector2(1430,528), tilescale)

	# Trucks with collision
	var truck_textures = [truck1_tex, truck1_tex]
	var columns_x = [120, 300, 480]
	var start_y = 280
	var row_spacing = 80
	var total_rows = 3
	for x_pos in columns_x:
		for row in range(total_rows):
			var y_pos = start_y - row * row_spacing
			var truck_tex = truck_textures[row % 2]
			place_static_obstacle(truck_tex, Vector2(x_pos, y_pos), Vector2(2, 2))

	# Other vehicles and elements with collision
	place_static_obstacle(truck2_tex, Vector2(900,500), tilescale2)
	place_static_obstacle(car1_tex, Vector2(800,200), tilescale2)
	place_sprite(traffic_signal_tex, Vector2(700,600), tilescale2)
	place_sprite(traffic_signal_tex, Vector2(700,300), tilescale2)
	var oldman = oldman_scene.instantiate()

	add_child(oldman)

# Places a non-collidable sprite
func place_sprite(texture, position, scale = Vector2(1,1)):
	var sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.position = position
	sprite.scale = scale
	add_child(sprite)

# Places an object with StaticBody2D and collision
func place_static_obstacle(texture, position, scale = Vector2(1,1)):
	var static_body = StaticBody2D.new()
	static_body.position = position

	var sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.scale = scale
	static_body.add_child(sprite)

	var collision_shape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = texture.get_size() * scale * 0.6  # slightly smaller for tighter fit
	collision_shape.shape = shape
	collision_shape.position = Vector2.ZERO
	static_body.add_child(collision_shape)

	add_child(static_body)


func _on_topexit_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_bottomexit_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_leftexit_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
