tool
extends Resource

export(DynamicFontData) var regular
export(DynamicFontData) var italic
export(DynamicFontData) var bold
export(DynamicFontData) var bold_italic
export(DynamicFontData) var light
export(DynamicFontData) var light_italic
export(DynamicFontData) var semi_bold
export(DynamicFontData) var semi_bold_italic
export(DynamicFontData) var extra_bold
export(DynamicFontData) var extra_bold_italic

class_name FontCollection

func get_font(emphasis):
	match emphasis:
		Constants.Emphasis.REGULAR:
			return regular
		Constants.Emphasis.ITALIC:
			return italic
		Constants.Emphasis.BOLD:
			return bold
		Constants.Emphasis.BOLD_ITALIC:
			return bold_italic
		Constants.Emphasis.LIGHT:
			return light
		Constants.Emphasis.LIGHT_ITALICS:
			return light_italic
		Constants.Emphasis.SEMI_BOLD:
			return semi_bold
		Constants.Emphasis.SEMI_BOLD_ITALICS:
			return semi_bold_italic
		Constants.Emphasis.EXTRA_BOLD:
			return extra_bold
		Constants.Emphasis.EXTRA_BOLD_ITALICS:
			return extra_bold_italic
		_:
			return null
