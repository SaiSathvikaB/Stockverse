extends Control

@onready var coin_display = $coins
@onready var profit_loss_display = $companylist/company1/p_l
@onready var edu_message = $edumessage
@onready var company_list = $companylist

var coins := 10000
var portfolio = [0, 0, 0]  # Stocks owned for 3 companies
var prices = [100, 150, 200]  # Current prices
var base_prices = [100, 150, 200]  # Base prices for P/L calc

func _ready():
	update_ui()
	connect_buttons()

func update_ui():
	coin_display.text = "Coins: %d" % coins
	for i in range(3):
		var company_node = company_list.get_child(i)
		var stock_owned = portfolio[i]
		var price = prices[i]
		var base_price = base_prices[i]
		var p_label = company_node.get_node("ProfitLossLabel")
		var s_label = company_node.get_node("StocksOwnedLabel")
		s_label.text = "Stocks: %d" % stock_owned

		if stock_owned > 0:
			var profit_loss = (price - base_price) * stock_owned
			p_label.text = "P/L: %d" % profit_loss
		else:
			p_label.text = "P/L: -"

func connect_buttons():
	for i in range(3):
		var company_node = company_list.get_child(i)
		company_node.get_node("BuyButton").pressed.connect(func(): buy_stock(i))
		company_node.get_node("SellButton").pressed.connect(func(): sell_stock(i))

func buy_stock(i):
	if coins >= prices[i]:
		coins -= prices[i]
		portfolio[i] += 1
		update_ui()

func sell_stock(i):
	if portfolio[i] > 0:
		coins += prices[i]
		portfolio[i] -= 1
		update_ui()

func set_educational_tip(text):
	edu_message.text = text
