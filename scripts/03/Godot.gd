extends Area2D

var Bullet = preload("res://scenes/03/Bullet.tscn")

onready var life = 100 setget set_life
onready var shield = 100 setget set_shield
var refill_shield = false
onready var bleeding_timer = 100 setget set_bleeding_timer
var bleeding = false
var damage = 40
var death = false

signal shield
signal no_shield
signal bleeding
signal death

func set_life(value):
	life = value
	$VBoxContainer/Life.value = value

func set_shield(value):
	if value < shield:
		refill_shield = false
	shield = value
	$VBoxContainer/Shield.value = value

func set_bleeding_timer(value):
	bleeding_timer = value
	$Timer.value = value
	if bleeding and value == 0:
		bleeding = false
		set_bleeding_timer(0)
		death = true
		$AnimationPlayer2.play("death")
		emit_signal("death")




func _ready():
	connect("area_entered", self, "on_area_entered")
	$TimerThree.connect("timeout", self, "refill_shield_timer")
	$TimerFive.connect("timeout", self, "refill_shield_timer")

func refill_shield_timer():
	refill_shield = true
	emit_signal("shield")
	
func _process(delta):
	if refill_shield:
		set_shield(min(shield + delta * 50, 100))
	if bleeding:
		set_bleeding_timer(max(bleeding_timer - delta * 50, 0))

func _input(event):
	if !death:
		if event.is_action_pressed("action1"):
			var bullet_inst = Bullet.instance()
			bullet_inst.position = Vector2(290, 710)
			$"..".add_child(bullet_inst)
		if event.is_action_pressed("action2") and !$AnimationPlayer.is_playing():
			$AnimationPlayer.play("attack")
	if event.is_action("reset"):
		death = false
		set_life(100)
		set_shield(100)
		set_bleeding_timer(0)
		$Sprite.modulate = Color.white
		emit_signal("shield")
		

func survive():
	if bleeding:
		bleeding = false
		set_bleeding_timer(0)
		set_life(25)
		set_shield(100)
		emit_signal("shield")

func on_area_entered(area: Area2D):
	if !death:
		take_damage()
		area.queue_free()

func take_damage():
	$TimerThree.stop()
	$TimerFive.stop()
	if shield > 0:
		var new_shield = max(shield - damage, 0)
		set_shield(new_shield)
		if new_shield > 0:
			$TimerThree.start()
		else:
			emit_signal("no_shield")
			$TimerFive.start()
		
	elif life > 0:
		$TimerFive.start()
		var new_life = max(life - damage, 0)
		set_life(new_life)
		if new_life == 0:
			set_bleeding_timer(100)
			bleeding = true
			$TimerFive.stop()
			emit_signal("bleeding")
