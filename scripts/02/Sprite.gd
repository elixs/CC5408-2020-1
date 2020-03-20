extends Sprite

var limits = Rect2(Vector2(85, 255), Vector2(1750, 700))

var direction
var speed = 500
var ready = false

func _ready():
	connect("hide", self, "hide")
#	restart()

func hide():
	ready = false
	restart()

func restart():
	position = limits.position + limits.size / 2
	direction = Vector2(pow(-1, randi() % 2) * rand_range(0.5,0.8), 
						pow(-1, randi() % 2) * rand_range(0.2,0.5)).normalized()
	modulate = Color.white
	
func _physics_process(delta):
	if visible and not ready:
		ready = true
		restart()
	if ready:
		position += direction * speed * delta
		if position.x > limits.position.x + limits.size.x - 64 or \
			position.x < limits.position.x + 64:
			direction.x = -direction.x
			bounce()
		if position.y > limits.position.y + limits.size.y - 64 or \
			position.y < limits.position.y + 64:
			direction.y = -direction.y
			bounce()
	

func bounce():
	modulate = Color(randf(), randf(), randf())
