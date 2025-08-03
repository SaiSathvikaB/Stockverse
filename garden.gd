extends Node2D
var oldman_scene = preload("res://old_man.tscn")
# Preload textures
var grass_tex = preload("res://assets/tiles/darkgrass.jpg")
var tree_tex = preload("res://assets/garden/Tree1 (2).png") 
var water_tex = preload("res://assets/tiles/water.jpg") 
var flower1_tex = preload("res://assets/garden/Flower 3 - BLUE.png") 
var panda_tex = preload("res://assets/garden/RedPandaSpriteSheet-ezgif.com-crop (2).png") 
var porc_tex = preload("res://assets/garden/Porcupine-spritesheet-ezgif.com-crop (1).png") 
var fence1_tex = preload("res://assets/garden/fence1.png")  # Horizontal fence
var fence2_tex = preload("res://assets/garden/fence2.png")  # Vertical fence
var path_tex = preload("res://assets/tiles/Tile_17-128x128.png")

var tile_size = Vector2(30, 30)
var map_width = 1600
var map_height = 800
var ani1_scale = Vector2(4, 4)
var ani_scale = Vector2(3, 3)
var tile_scale = Vector2(2, 2)  # scale for grass and water tiles
var tree_scale = Vector2(2, 2) 
var path_scale = Vector2(0.7, 0.7)

func _ready():
	# Fill entire map with dark grass
	for x in range(0, map_width, tile_size.x):
		for y in range(0, map_height, tile_size.y):
			place_tile(grass_tex, Vector2(x, y), tile_scale)

	# Flowers
	place_tile(flower1_tex, Vector2(100,50))
	place_tile(flower1_tex, Vector2(1000,200))
	place_tile(flower1_tex, Vector2(300,400))
	place_tile(flower1_tex, Vector2(200,300), tree_scale)		
	place_tile(flower1_tex, Vector2(1000,300), tree_scale)
	place_tile(flower1_tex, Vector2(450,50), tree_scale)

	# Animals (no collision)
	place_tile(panda_tex, Vector2(400,500), ani1_scale, false)
	place_tile(porc_tex, Vector2(100,300), ani_scale, false)

	# Add trees, water pool, fences and path
	add_tree_u_shape()
	add_central_water_pool()
	add_inner_fence_u()
	add_horizontal_path()
	var oldman = oldman_scene.instantiate()

	add_child(oldman)


# General function to place any tile with optional collision
func place_tile(texture: Texture2D, position: Vector2, scale := Vector2(1, 1), add_collision := false) -> void:
	var sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.position = position
	sprite.scale = scale
	add_child(sprite)

	if add_collision:
		var static_body = StaticBody2D.new()
		static_body.position = position
		add_child(static_body)

		var collision_shape = CollisionShape2D.new()
		var shape = RectangleShape2D.new()
		shape.extents = (texture.get_size() * scale) / 2.0
		collision_shape.shape = shape
		collision_shape.position = Vector2.ZERO
		static_body.add_child(collision_shape)


func add_tree_u_shape():
	var start_x = 50
	var end_x = 1450
	var bottom_y = 650
	var vertical_height = 300
	var spacing = 120

	for i in range(3):
		var x = start_x + i * 100
		for y in range(bottom_y, bottom_y - vertical_height, -spacing):
			place_tile(tree_tex, Vector2(x, y), tree_scale, true)

	for i in range(3):
		var x = end_x - i * 100
		for y in range(bottom_y, bottom_y - vertical_height, -spacing):
			place_tile(tree_tex, Vector2(x, y), tree_scale, true)

	for x in range(start_x, end_x + 1, 100):
		place_tile(tree_tex, Vector2(x, bottom_y), tree_scale, true)


func add_central_water_pool():
	var pool_center = Vector2(750,450)
	var pool_width = 600
	var pool_height = 220
	var radius = 60
	var spacing = 20

	for x in range(int(pool_center.x - pool_width / 2), int(pool_center.x + pool_width / 2), spacing):
		for y in range(int(pool_center.y - pool_height / 2), int(pool_center.y + pool_height / 2), spacing):
			var point = Vector2(x, y)

			var dx = abs(x - pool_center.x)
			var dy = abs(y - pool_center.y)

			if dx > (pool_width / 2 - radius):
				var edge_dx = dx - (pool_width / 2 - radius)
				if edge_dx * edge_dx + dy * dy > radius * radius:
					continue

			place_tile(water_tex, point, tile_scale, true)


func add_inner_fence_u():
	var left_x = 300
	var right_x = 1200
	var top_y = 350
	var fence_gap = 20

	for x in range(left_x + 40, right_x - 19, 40):
		var pos = Vector2(x, 570)
		place_tile(fence1_tex, pos, Vector2(1,1), true)

	for y in range(top_y, 570, 40):
		var pos = Vector2(left_x + fence_gap, y)
		place_tile(fence2_tex, pos, Vector2(1,1), true)

	for y in range(top_y, 570, 40):
		var pos = Vector2(right_x - fence_gap + 10, y)
		place_tile(fence2_tex, pos, Vector2(1,1), true)


func add_horizontal_path():
	var y_start = 150
	var path_height = 1

	for y in range(y_start, y_start + (40 * path_height), 40):
		for x in range(0, map_width, 80):
			place_tile(path_tex, Vector2(x, y), path_scale, false)
