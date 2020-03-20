tool
extends Label

#class_name EmphasisLabel

export(Constants.Emphasis) onready var emphasis setget set_emphasis

export(int) var font_size = 16 setget set_font_size
export(Resource) var font_collection setget set_font_collection

func set_emphasis(new_emphasis: int):
	if font_collection:
		if new_emphasis == Constants.Emphasis.NONE:
			set("custom_fonts/font", null)
			emphasis = new_emphasis
			return
		var font_data = font_collection.get_font(new_emphasis)
		if font_data:
			var font = get("custom_fonts/font")
			
			if not font:
				var new_font = DynamicFont.new()
				new_font.font_data = font_data
				set_font_properties(new_font)
				set("custom_fonts/font", new_font)
			else:
				font.font_data = font_data
				set_font_properties(font)
			emphasis = new_emphasis
		else:
			printerr("Missing Error: The Font Collection doesn't have the ",
			Constants.Emphasis.keys()[new_emphasis].capitalize(),
			 " emphasis")
	elif new_emphasis != Constants.Emphasis.NONE:
		printerr("Missing Error: There is no Font Collection")

func set_font_properties(font):
	font.size = font_size
	var extra_spacing = -font_size/5
	if valign == VALIGN_TOP:
		font.extra_spacing_top = 0
		font.extra_spacing_bottom = extra_spacing
	if valign == VALIGN_BOTTOM:
		font.extra_spacing_top = extra_spacing
		font.extra_spacing_bottom = 0

func set_font_size(new_font_size):
	font_size = new_font_size
	var font = get("custom_fonts/font")	
	if font:
		set_font_properties(font)

func set_font_collection(new_font_collection):
	if new_font_collection:
		font_collection = new_font_collection.duplicate()

func _set(property: String, value):
	if property == "text":
		if typeof(value) == TYPE_STRING:
#			print(value)			
			set_text(value.replace("\t", "...."))
			return true
