extends VideoPlayer


export (Array, VideoStream) var streams

export(bool) var loop = true
export(bool) var play = true

var current_stream = 0
var enabled

func _input(event):
	if $"../..".visible:
		if event.is_action_pressed("start"):
			paused = enabled
			enabled = !enabled
		if event.is_action_pressed("next"):
			if is_playing():
				stop()
		if event.is_action_pressed("previous"):
			if is_playing():
				current_stream -= 2
				current_stream %= streams.size()
				stop()
			
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enabled:
		if rect_scale.x * rect_size.x < get_viewport_rect().size.x and \
			rect_scale.y * rect_size.y < get_viewport_rect().size.y:
			var scale = get_viewport_rect().size / rect_size
			var min_scale = min(scale.x, scale.y)
			rect_pivot_offset = rect_size / 2
			rect_scale = Vector2(min_scale, min_scale)
	
		if not is_playing() and play and streams.size():
			stream = streams[current_stream]
			current_stream += 1
			current_stream %= streams.size()
	
			play()
#	else:
#		paused = true
	if not $"../..".visible:
		enabled = false
		current_stream = 0
		stream = streams[current_stream]
		stop()
		
