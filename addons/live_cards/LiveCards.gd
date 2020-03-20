extends Node2D

# There has to be a base CanvasLayer 00 which will be always visible
# The slide show start from 01


var current = 0 setget set_current

func _ready():
	start()

func _input(event):
	if event.is_action_pressed("ui_right"):
		next()
	if event.is_action_pressed("ui_left"):
		prev()
	if event.is_action_pressed("ui_home"):
		start()
	if event.is_action_pressed("ui_end"):
		end()

func next():
	set_current(current + 1)

func prev():
	set_current(current - 1)

func start():
	var cards = get_cards()
	set_current(min(1, cards.size() - 1))

func end():
	var cards = get_cards()
	set_current(cards.size() - 1)


func set_current(value):
	var cards = get_cards()
	current = clamp(value, 1, cards.size() - 1)
	$"00/Panel/Number".text = str(current)
	for i in range(cards.size()):
		for child in cards[i].get_children():
			child.visible = i == current || i == 0
		
func get_cards():
	var cards = []
	for child in get_children():
		if child.is_class("CanvasLayer") and child.has_node("Panel"):
			cards.append(child)
	return cards
