tool
extends VBoxContainer

const Empty = preload("res://addons/live_cards/cards/Empty.tscn")
const Title = preload("res://addons/live_cards/cards/Title.tscn")
const TitleAndBody = preload("res://addons/live_cards/cards/TitleAndBody.tscn")
const TitleAndPicture = preload("res://addons/live_cards/cards/TitleAndPicture.tscn")

signal side_button_pressed(value)

var current = 0 setget set_current

func _ready():
#	get_node("Button").connect("pressed", self, "_on_Button_pressed")
	$CreateLiveCards.connect("pressed", self, "create_live_cards")
	$AddEmpty.connect("pressed", self, "add_empty_card")
	$AddTitle.connect("pressed", self, "add_title_card")
	$AddTitleAndBody.connect("pressed", self, "add_title_and_body_card")
	$AddTitleAndPicture.connect("pressed", self, "add_title_and_picture_card")
	$FileDialog.connect("confirmed", self, "create_live_cards_confirmed")
	$FileDialog.current_file = ".tscn"
	$Controls/Next.connect("pressed", self, "next")
	$Controls/Prev.connect("pressed", self, "prev")

func create_live_cards():
	$FileDialog.popup_centered_ratio()
			
func reown(node, owner):
#	if is_instance_valid(node.owner):
	node.set_owner(owner)
	for child in node.get_children():
		reown(child, owner)

func add_child_to_owner(child, owner):
	owner.add_child(child)
	child.set_owner(owner)

func add_card(card_scene):
	var root = get_tree().get_edited_scene_root()
	var new_card = CanvasLayer.new()
	add_child_to_owner(new_card, root)
	new_card.set_name("00")
	new_card.set_layer(-1)
	var card_instance = card_scene.instance(1)
	new_card.add_child(card_instance)
	card_instance.set_owner(root)
	end()

func add_empty_card():
	add_card(Empty)

func add_title_card():
	add_card(Title)
	
func add_title_and_body_card():
	add_card(TitleAndBody)

func add_title_and_picture_card():
	add_card(TitleAndPicture)
	
	
func create_live_cards_confirmed():
	print($FileDialog.current_path)
	var packed_scene = PackedScene.new()
	packed_scene.pack(preload("res://addons/live_cards/LiveCards.tscn").instance())
	ResourceSaver.save($FileDialog.current_path, packed_scene)
	$FileDialog.current_file = ""

#func _input(event):
#	if event.is_action_pressed("ui_right"):
#		next()
#	if event.is_action_pressed("ui_left"):
#		prev()
#	if event.is_action_pressed("ui_home"):
#		start()
#	if event.is_action_pressed("ui_end"):
#		end()

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
	current = clamp(value, 0, cards.size() - 1)
	$Controls/Number.text = str(current)
	for i in range(cards.size()):
		for child in cards[i].get_children():
			child.visible = i == current || i == 0
			
#		cards[i].get_node("Panel").visible = i == current || i == 0
		
func get_cards():
	var root = get_tree().get_edited_scene_root()
	var cards = []
	for child in root.get_children():
		if child.is_class("CanvasLayer") and child.has_node("Panel"):
#			print(child.owner)
			cards.append(child)
	return cards
		
