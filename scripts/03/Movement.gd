extends KinematicBody2D


enum Type {POSITION, VELOCITY, FRICTION, JUMP, GRAVITY}
#var current_type = Type.POSITION setget set_current_type
var current_type = Type.POSITION


var speed = 10
var friction = 0.5
var gravity = 1

var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Panel/VBoxContainer/OptionButton.connect("item_selected", self, "on_item_selected")
	$CanvasLayer/Panel/VBoxContainer/HSlider.connect("value_changed", self, "on_speed_value_changed")
	$CanvasLayer/Panel/VBoxContainer/HSlider2.connect("value_changed", self, "on_friction_value_changed")
	for type in Type.keys():
		$CanvasLayer/Panel/VBoxContainer/OptionButton.add_item(type.capitalize())

func on_speed_value_changed(value: float):
	speed = value

func on_friction_value_changed(value: float):
	friction = 1 - value

func on_item_selected(id: int):
	current_type = id

func set_current_type(value):
	current_type = value

func _process(delta):
	$CanvasLayer/Panel.visible = visible


func _physics_process(delta):
	
	if visible:
		var input_x = Input.get_action_strength("right") - Input.get_action_strength("left")
		match current_type:
			Type.POSITION:
#				print($CanvasLayer/Panel/OptionButton.selected)
				position.x +=  input_x * speed
			Type.VELOCITY:
				velocity.x = (input_x * speed / delta if input_x else velocity.x)
				velocity.y = 0
				velocity = move_and_slide(velocity)
			Type.FRICTION:
				velocity.x = lerp(velocity.x, input_x * speed / delta, 1 - friction)
				velocity.y = 0
				velocity = move_and_slide(velocity)
			Type.JUMP:
				velocity.x = lerp(velocity.x, input_x * speed / delta, 1 - friction)
				if Input.is_action_just_pressed("jump"):
					velocity.y = -gravity / delta * 20
				velocity = move_and_slide(velocity)
			Type.GRAVITY:
				velocity.x = lerp(velocity.x, input_x * speed / delta, 1 - friction)
				if Input.is_action_just_pressed("jump"):
					velocity.y = -gravity / delta * 20
				velocity.y += gravity / delta
				velocity = move_and_slide(velocity)
				

func _input(event):
	if event is InputEventKey and event.is_pressed() and  event.scancode == KEY_M:
		visible = !visible
