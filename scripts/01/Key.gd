extends Area2D

func _ready():
	connect("body_entered", self, "on_body_entered")

func on_body_entered(body: Node):
	if body.name == "Kao-chan":
		get_node("../Flag").activate()
		disable()

func restart():
	visible = true
	$CollisionShape2D.set_deferred("disabled", true)
	
func start():
	$CollisionShape2D.set_deferred("disabled", false)

func disable():
	$CollisionShape2D.set_deferred("disabled", true)
	visible = false
