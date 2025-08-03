extends Control

var prices = [[], [], []] # For B, R, G
var rng = RandomNumberGenerator.new()

func _ready():
	custom_minimum_size = Vector2(500,150)  # width x height


 


	# Offset to center it horizontally
	position = Vector2(450, 10)  # 10 px from the top


	rng.randomize()
	for i in range(3):
		prices[i].append(100.0)

func _process(delta):
	for i in range(3):
		var last = prices[i][-1]
		var new_price = last + rng.randfn() * 2
		new_price = clamp(new_price, 1, 200)
		prices[i].append(new_price)
		if prices[i].size() > 100:
			prices[i].pop_front()
	queue_redraw()

func _draw():
	var colors = [Color.GREEN, Color.RED, Color.BLUE]
	for i in range(3):
		var points = []
		for j in range(prices[i].size()):
			var x = j * 5
			var y = 100 - prices[i][j] * 0.5
			points.append(Vector2(x, y))
		draw_polyline(points, colors[i], 2)
