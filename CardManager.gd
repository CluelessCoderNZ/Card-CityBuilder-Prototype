extends Node

# Card Loading
var CARD_DEFAULT = load("res://Cards/DefaultCard.tscn")
var CARD_HOUSING = load("res://Cards/HousingCard.tscn")

# Card List
var CARD_LIST =    [CARD_DEFAULT,
					CARD_HOUSING]

func get_card_count():
	return CARD_LIST.size()

func get_card_instance(card_id):
	if card_id >= 0 and card_id < CARD_LIST.size():
		return CARD_LIST[card_id].instance()
	else:
		return null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
