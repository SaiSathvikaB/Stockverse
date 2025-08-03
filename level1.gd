extends Node2D

var PlayerScene = preload("res://player.tscn")

# Preload textures
var grass_tex = preload("res://assets/tiles/stonepath.png")
var roadfront_tex = preload("res://assets/tiles/roadfront.png")
var roadleft_tex = preload("res://assets/tiles/roadleft.png")
var b1_tex = preload("res://assets/buildings/downtown1.png")
var b3_tex = preload("res://assets/buildings/dt2-removebg-preview.png")

var b5_tex = preload("res://assets/buildings/dt3-removebg-preview.png")
var b7_tex = preload("res://assets/buildings/dt4-removebg-preview.png")
var b8_tex = preload("res://assets/buildings/dt7-removebg-preview.png")
var ic_tex = preload("res://assets/buildings/dt8-removebg-preview.png")
var hospital2_tex = preload("res://assets/buildings/dt10-removebg-preview.png")
var police_tex = preload("res://assets/buildings/dt9-removebg-preview.png")
var tree_tex = preload("res://assets/tiles/dttree2.png")

func _ready():
	print("Map initializing...")

	# Fill background with grass
	for x in range(0, 1500 + 19, 19):
		for y in range(0, 700 + 22, 22):
			place_sprite(grass_tex, Vector2(x, y))

	# Place vertical road using roadfront (scaled 6x)
	var roadfront_scale = Vector2(5, 5)
	var roadfront_width = 32 * 4  # = 192
	for y in range(0, 700 + roadfront_width,50):
		var sprite = Sprite2D.new()
		sprite.texture = roadfront_tex
		sprite.scale = roadfront_scale
		sprite.position = Vector2(870, y)
		add_child(sprite)

	# Place horizontal road using roadleft (scaled 6x)
	var roadleft_scale = Vector2(6, 6)
	var roadleft_height = 32 * 6  # = 192
	for x in range(0, 700 + roadleft_height, 50):
		var sprite = Sprite2D.new()
		sprite.texture = roadleft_tex
		sprite.scale = roadleft_scale
		sprite.position = Vector2(x, 300)
		add_child(sprite)

	# Buildings (scaled 3x)
	var bscale = Vector2(3, 3)
	place_static_obstacle(hospital2_tex, Vector2(200, 100), Vector2(128, 128), bscale)
	place_static_obstacle(hospital2_tex, Vector2(400, 100), Vector2(128, 128), bscale)
	place_static_obstacle(b1_tex, Vector2(1100, 160), Vector2(128, 128), bscale)
	place_static_obstacle(b7_tex, Vector2(1100, 500), Vector2(128, 128), bscale)
	place_static_obstacle(b7_tex, Vector2(1350, 500), Vector2(128, 128), bscale)
	place_static_obstacle(b8_tex, Vector2(1400, 220), Vector2(128, 128), bscale)

	place_static_obstacle(ic_tex, Vector2(730, 500), Vector2(128, 128), bscale)
	place_static_obstacle(b3_tex, Vector2(300, 490), Vector2(128, 128), bscale)
	place_static_obstacle(b5_tex, Vector2(500, 500), Vector2(128, 128), bscale)
	place_static_obstacle(police_tex, Vector2(650, 120), Vector2(128, 128), bscale)

	# Trees (now scaled 3x)
	place_trees(Vector2(3, 3))

	# Player
	var player = PlayerScene.instantiate()
	player.position = Vector2(750, 80)
	player.z_index = 1
	add_child(player)

func place_trees(tree_scale := Vector2(1, 1)):
	var dots = [
		Vector2(1270, 50), Vector2(1050, 150), Vector2(950, 80),
		Vector2(820, 600), Vector2(1450, 500), Vector2(100, 270),
		Vector2(600, 270), Vector2(700, 270)
	]
	for pos in dots:
		place_static_obstacle(tree_tex, pos, Vector2(64, 64), tree_scale)

func place_sprite(texture, pos):
	var sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.position = pos
	add_child(sprite)

func place_static_obstacle(texture, pos, collision_size, scale := Vector2(1, 1)):
	var static_body = StaticBody2D.new()
	static_body.position = pos

	var sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.position = Vector2.ZERO
	sprite.scale = scale
	static_body.add_child(sprite)

	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = (collision_size * scale) / 2
	collision.shape = shape
	collision.position = Vector2.ZERO
	static_body.add_child(collision)

	add_child(static_body)
