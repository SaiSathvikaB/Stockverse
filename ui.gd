extends Control

@onready var money_label = $header/money
@onready var b_label = $header/stockcontainer/bcount
@onready var r_label = $header/stockcontainer/rcount
@onready var g_label = $header/stockcontainer/gcount
@onready var deal_container = $deal
@onready var timer = $Timer

var money = 10000.0
var stocks = [0, 0, 0]

var active_deals = []
var deal_scene = preload("res://deal.tscn")

func _ready():
	size = Vector2(500, 500)
	update_ui()
	timer.wait_time = 1.5
	timer.one_shot = false
	timer.start()

func update_ui():
	money_label.text = "$%.2f" % money
	b_label.text = str(stocks[0])
	r_label.text = str(stocks[1])
	g_label.text = str(stocks[2])
func _on_Timer_timeout():
	var deal1 = deal_scene.instantiate()
	var deal2 = deal_scene.instantiate()
	var deal3 = deal_scene.instantiate()
	deal1.stock_idx = 0  # Blue
	deal2.stock_idx = 1  # Red
	deal3.stock_idx = 2  # Green

	# Position each deal at different y values (no overlap)
	deal1.position = Vector2(50, 200)
	deal2.position = Vector2(270, 200)
	deal3.position = Vector2(490, 200)
	for deal in [deal1, deal2, deal3]:
		deal.randomize_deal()
		deal.connect("deal_accepted", Callable(self, "_on_deal_accepted"))
		deal.connect("deal_discarded", Callable(self, "_on_deal_discarded"))
		deal_container.add_child(deal)


func _on_deal_accepted(stock_idx, is_buy, amount, price):
	var total = amount * price
	if is_buy == true:
		if money >= total:
			money -= total
			stocks[stock_idx] += amount
		else:
			return
	else:
		if stocks[stock_idx] >= amount:
			money += total
			stocks[stock_idx] -= amount
		else:
			return

	update_ui()
	_remove_deal_from_active(stock_idx, is_buy, amount, price)

func _on_deal_discarded():
	pass

func _remove_deal_from_active(stock_idx, is_buy, amount, price):
	for deal in active_deals:
		if deal.stock_idx == stock_idx and deal.is_buy == is_buy and deal.amount == amount and deal.price == price:
			active_deals.erase(deal)
			deal.queue_free()
			break
