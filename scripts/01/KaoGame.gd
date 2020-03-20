extends Node2D

func _ready():
	connect("hide", self, "restart")
	
func restart():
	$Key.restart()
	$Flag.restart()
	$"Kao-chan".restart()
