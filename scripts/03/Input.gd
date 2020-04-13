extends Node2D


var linear_vel = Vector2()
var target_vel = Vector2()
var speed = 500

var action_time = 5
var action_time_storage = 0
var is_moving = false




func _ready():
	randomize()	
	connect("visibility_changed", self, "on_visibility_changed")

func on_visibility_changed():
	$Godot/CollisionShape2D.disabled = !visible

func _physics_process(delta):
	if visible:
		linear_vel = $Godot.move_and_slide(linear_vel)
		linear_vel = lerp(linear_vel, target_vel * speed, 0.25)
		
		action_time_storage += delta
		if action_time_storage >= action_time:
			action_time = rand_range(0.2, 1.0)
			action_time_storage = 0
			if randi() % 2:
				if !is_moving:
					var new_vel = Vector2()
					if $Godot.position.x < 64:
						new_vel.x = randf()
					elif $Godot.position.x > 1920 - 64:
						new_vel.x = -randf()
					else:
						new_vel.x = 1.0 - 2.0 * randf()
					if $Godot.position.y < 64:
						new_vel.y = randf()
					elif $Godot.position.y > 1080 - 64:
						new_vel.y = -randf()
					else:
						new_vel.y = 1.0 - 2.0 * randf()
					move(new_vel)
			else:
				stop()


func move(vel):
	target_vel = vel
	$"Kao-chan".text = "· o ·)-"
	is_moving = true

func stop():
	target_vel = Vector2()
	$"Kao-chan".text = "· - ·)"
	is_moving = false
