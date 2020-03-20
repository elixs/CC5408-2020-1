extends Node2D


var Accent = preload("res://shaders/Accent.tres")


# Called when the node enters the scene tree for the first time.
func _ready():
	$"../Godot".connect("shield", self, "on_shield")
	$"../Godot".connect("no_shield", self, "on_no_shield")
	$"../Godot".connect("bleeding", self, "on_bleeding")
	$"../Godot".connect("death", self, "on_death")
	on_shield()

func on_shield():
	$Shield.material = Accent
	$NoShield.material = null
	$Bleeding.material = null
	$Death.material = null

func on_no_shield():
	$Shield.material = null
	$NoShield.material = Accent
	$Bleeding.material = null
	$Death.material = null

func on_bleeding():
	$Shield.material = null
	$NoShield.material = null
	$Bleeding.material = Accent
	$Death.material = null

func on_death():
	$Shield.material = null
	$NoShield.material = null
	$Bleeding.material = null
	$Death.material = Accent
