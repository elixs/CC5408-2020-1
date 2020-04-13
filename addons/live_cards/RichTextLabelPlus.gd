tool
extends RichTextLabel

class_name RichTextLabelPlus

export(int) var font_size = 16 setget set_font_size

func set_font_properties(font):
	font.size = font_size
	set_bbcode(bbcode_text)
#
func set_font_size(new_font_size):
	font_size = new_font_size
#	var mono_font = get("custom_fonts/mono_font")	
#	if mono_font:
#		set_font_properties(mono_font)
	var bold_italics_font = get("custom_fonts/bold_italics_font")	
	if bold_italics_font:
		set_font_properties(bold_italics_font)
	var italics_font = get("custom_fonts/italics_font")	
	if italics_font:
		set_font_properties(italics_font)
	var bold_font = get("custom_fonts/bold_font")	
	if bold_font:
		set_font_properties(bold_font)
	var normal_font = get("custom_fonts/normal_font")	
	if normal_font:
		set_font_properties(normal_font)

