extends "res://CardManager.gd"

var card_size = 130
var card_count = 0

func _ready():
	add_card(1)
	add_card(1)
	add_card(1)
	
func get_card_home_position(index):
	var hand_width = card_size * (card_count)
	var offsetX = index * card_size
	
	return Vector2(offsetX - hand_width/2.0 + card_size / 2.0, 0)

func reset_card_positions():
	var index = 0
	for i in range(get_children().size()):
		if get_children()[i].is_interactable:
			get_children()[i].move_to(get_card_home_position(index), 1.0)
			index += 1
	
func add_card(id):
	var card = get_card_instance(id)
	
	if card:
		# Temporary
		card.connect("on_release", self, "remove_card_after_use")
		
		card_count += 1
		add_child(card)
		reset_card_positions()

func remove_card_after_use(card):
	card.burn_card()
	card_count -= 1
	reset_card_positions()