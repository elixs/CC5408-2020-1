extends Area2D

var direction = Vector2(sin(PI/4), -cos(PI/4))

func _ready():
	$VisibilityNotifier2D.connect("screen_exited", self, "queue_free")

func _physics_process(delta):
	position += direction * 500 * delta
