extends Node2D
var oldman_scene = preload("res://scientist.tscn")
# Preload textures
var industry_tex = preload("res://assets/tiles/industrytile.png")
var road_tex = preload("res://assets/tiles/stonepath.png")
var tile_size = Vector2(30, 30)
var road_scale = Vector2(2.5, 2.5) 
var slaz_scale = Vector2(0.5, 0.5)
var build_scale = Vector2(2, 2)
var another_scale=Vector2(1,1)
# Building textures
var building1_tex = preload("res://assets/buildings/build1-removebg-preview.png")
var building2_tex = preload("res://assets/buildings/build2.png")
var building3_tex = preload("res://assets/buildings/build3-removebg-preview.png")
var building4_tex = preload("res://assets/buildings/building_1_sprite-removebg-preview.png")
var building5_tex = preload("res://assets/buildings/building_3_Sprite-removebg-preview.png")
var building6_tex = preload("res://assets/buildings/industry2_prev_ui-removebg-preview.png")
var building7_tex = preload("res://assets/buildings/industry3-removebg-preview.png")
var building8_tex = preload("res://assets/buildings/industry4-removebg-preview.png")
var building9_tex = preload("res://assets/buildings/industry5-removebg-preview.png")
var building10_tex = preload("res://assets/buildings/industry6-removebg-preview.png")
var building11_tex = preload("res://assets/buildings/industry7-removebg-preview.png")
var building12_tex = preload("res://assets/buildings/slazzer-edit-image-removebg-preview-Photoroom.png")
var building13_tex = preload("res://assets/buildings/Tank-removebg-preview.png")

func _ready():
	# Fill entire map with industry tiles
	for x in range(0, 1600, tile_size.x):
		for y in range(0, 800, tile_size.y):
			place_sprite(industry_tex, Vector2(x, y))

	# Vertical road
	var road_x = 810
	for y in range(800, 350, -tile_size.y):
		place_sprite(road_tex, Vector2(road_x, y), road_scale)

	# Horizontal road
	var road_y = 300
	for x in range(0, 818, tile_size.x):
		place_sprite(road_tex, Vector2(x, road_y), road_scale)

	# BUILDINGS with collision
	place_sprite(building1_tex, Vector2(70, 100), build_scale, true)
	place_sprite(building2_tex, Vector2(150, 130), build_scale, true)
	place_sprite(building3_tex, Vector2(400, 130), build_scale, true)
	place_sprite(building2_tex, Vector2(250, 130), build_scale, true)
	place_sprite(building2_tex, Vector2(200, 130), build_scale, true)
	place_sprite(building2_tex, Vector2(300, 130), build_scale, true)
	place_sprite(building4_tex, Vector2(400, 400), build_scale, true)
	place_sprite(building5_tex, Vector2(200, 400), build_scale, true)
	place_sprite(building6_tex, Vector2(1200, 200), another_scale,true)
	place_sprite(building7_tex, Vector2(1200, 450), build_scale, true)
	place_sprite(building8_tex, Vector2(950, 600), build_scale, true)
	place_sprite(building11_tex, Vector2(600, 500), build_scale, true)
	place_sprite(building9_tex, Vector2(550, 550), build_scale, true)
	place_sprite(building10_tex, Vector2(650, 560), build_scale, true)
	place_sprite(building12_tex, Vector2(650, 100), slaz_scale, true)
	place_sprite(building13_tex, Vector2(850, 150), build_scale, true)
	
	var oldman = oldman_scene.instantiate()

	add_child(oldman)

# Helper to place sprites, optionally with collision
func place_sprite(texture, position, scale = Vector2(1, 1), add_collision := false):
	if add_collision:
		var static_body = StaticBody2D.new()
		static_body.position = position

		var collision = CollisionShape2D.new()
		var shape = RectangleShape2D.new()
		var texture_size = texture.get_size() * scale
		shape.size = texture_size
		collision.shape = shape
		collision.position = Vector2.ZERO
		static_body.add_child(collision)

		var sprite = Sprite2D.new()
		sprite.texture = texture
		sprite.scale = scale
		sprite.position = Vector2.ZERO  # relative to StaticBody2D
		static_body.add_child(sprite)

		add_child(static_body)
	else:
		var sprite = Sprite2D.new()
		sprite.texture = texture
		sprite.position = position
		sprite.scale = scale
		add_child(sprite)
