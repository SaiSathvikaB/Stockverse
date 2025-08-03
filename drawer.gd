extends Control

var prices = [120, 125, 130, 128, 135, 140, 138, 145, 150, 155]
var max_price := 160
var min_price := 100

func set_prices(new_prices: Array) -> void:
	prices = new_prices.duplicate()  # Copy to avoid external changes affecting this directly
	queue_redraw()

func _ready():
	call_deferred("queue_redraw")
	var timer = Timer.new()
	timer.wait_time = 5  # 900 seconds = 15 minutes
	timer.one_shot = false
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
func _on_timer_timeout():
	# Update prices here with new data
	update_prices()
	queue_redraw()
func update_prices():
	# Example: shift prices and add a new random price
	prices.pop_front()
	var last_price = prices[prices.size() - 1]
	var new_price = last_price + randi() % 10 - 5  # Random walk
	new_price = clamp(new_price, min_price, max_price)
	prices.append(new_price)
	

func scale_price_to_y(price):
	var height = size.y
	# Higher price = lower Y (top of control)
	return height - ((price - min_price) / (max_price - min_price) * height)

func _draw():
	draw_rect(Rect2(Vector2.ZERO, size), Color(0, 0, 0, 0.2))
	
	if prices.size() < 2:
		return
	
	var width = size.x
	var point_count = prices.size()
	var step_x = width / float(point_count - 1)
	
	for i in range(point_count - 1):
		var start_pos = Vector2(i * step_x, scale_price_to_y(prices[i]))
		var end_pos = Vector2((i + 1) * step_x, scale_price_to_y(prices[i + 1]))
		draw_line(start_pos, end_pos, Color(0, 1, 0), 3)
	
	for i in range(point_count):
		var pos = Vector2(i * step_x, scale_price_to_y(prices[i]))
		draw_circle(pos, 4, Color(1, 1, 0))
