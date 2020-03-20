extends Area2D

func _ready():
	connect("body_entered", self, "on_body_entered")
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.connect("animation_finished", self, "on_animation_finished")

func on_body_entered(body: Node):
	if body.name == "Kao-chan":
		get_node("/root/LiveCards").next()
	
func activate():
	$AnimationPlayer.play("activate")

func on_animation_finished(anim_name: String):
	if anim_name == "activate" and visible:
		$CollisionShape2D.set_deferred("disabled", false)

func restart():
	visible = true
	$AnimationPlayer.stop()
	$FinishFlag.scale = Vector2(3, 0)
	$CollisionShape2D.set_deferred("disabled", true)
