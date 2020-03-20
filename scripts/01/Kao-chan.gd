extends KinematicBody2D


const GRAVITY = Vector2(0, 1800)
const FLOOR_NOMAL = Vector2(0, -1)
const WALK_SPEED = 300
const RUN_SPEED = 500
const JUMP_SPEED = 1000

var linear_velocity = Vector2()

var enabled = false

var animation_timer = 0
var walking_animation = ["· o ·)", "-· o ) ", "· o ·)", " o · )-"]
var idle_animation = ["· - ·)", "-· - ·)"]
var current_frame = 0

var facing_right = true

func _ready():
	$AnimationPlayer.connect("animation_finished", self, "on_animation_finished")

func on_animation_finished(anim_name: String):
	if anim_name == "start" and visible:
		enabled = true
		$"../Key".start()

func _input(event):
	if visible:
		if event.is_action_pressed("start"):
			if not enabled and not $AnimationPlayer.is_playing():
				$AnimationPlayer.play("start")
			


func _physics_process(delta):
	if enabled and visible:
		var old_position = position
		
		
		# Gravity
		linear_velocity += delta * GRAVITY
		
		# Movement
		linear_velocity = move_and_slide(linear_velocity, FLOOR_NOMAL)
		var on_floor = is_on_floor()
		
		# Horizontal
		var input_speed = int(Input.is_action_pressed("right")) \
			- int(Input.is_action_pressed("left"))
			
		var speed = RUN_SPEED if Input.is_action_pressed("run") else WALK_SPEED
		
		
		
		linear_velocity.x = lerp(linear_velocity.x, input_speed * speed, 0.2)
	
		# Jump
		if on_floor and Input.is_action_just_pressed("jump"):
			linear_velocity.y = - JUMP_SPEED
			
		# Animation
		if linear_velocity.x > 0:
			facing_right = true
		if linear_velocity.x < 0:
			facing_right = false
		$Label.rect_scale.x = 2 * int(facing_right) - 1
		if abs(linear_velocity.x) > WALK_SPEED / 5:
			if animation_timer > WALK_SPEED * 5:
				$Label.text = walking_animation[current_frame]
				current_frame = (current_frame + 1) % walking_animation.size()
				animation_timer = 0
		else:
			current_frame = 0
			$Label.text = "· - ·)"
			
		
		animation_timer += abs(linear_velocity.x)

func restart():
	visible = true
	$AnimationPlayer.stop()
	position = Vector2(960, 650)
	$Label.text = "^ - ^)°"
	$Label.rect_scale.x = 1
	enabled = false
	$CollisionShape2D.set_deferred("disabled", false)
#
func disable():
	enabled = false
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.stop()


	
		

# Animation
# · - ·)
# · - ·)-
# -· - ·)
