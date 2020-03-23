tool
extends EditorPlugin

#const Screen = preload("res://addons/live_cards/screen.tscn")
const Side = preload("res://addons/live_cards/Side.tscn")

#var screen_instance
var side_instance

func _enter_tree():
	
	add_custom_type("EmphasisLabel", "Label", preload("EmphasisLabel.gd"), load("res://addons/live_cards/Label.svg"))
	
#   screen_instance = Screen.instance()
	side_instance = Side.instance()

   # Add the main panel to the editor's main viewport.
#   get_editor_interface().get_editor_viewport().add_child(screen_instance)

   # Add the side panel to the Upper Left (UL) dock slot of the left part of the editor.
   # The editor has 4 dock slots (UL, UR, BL, BR) on each side (left/right) of the main screen.
	add_control_to_dock(DOCK_SLOT_LEFT_UL, side_instance)

   # Hide the main panel
#	make_visible(false)

func _exit_tree():
	remove_custom_type("EmphasisLabel")
	
	
#   screen_instance.queue_free()
	remove_control_from_docks(side_instance)
	side_instance.queue_free()

#func _ready():
#   screen_instance.connect("main_button_pressed", screen_instance, "_on_main_button_pressed")
#   side_instance.connect("side_button_pressed", side_instance, "_on_side_button_pressed")

#func has_main_screen():
#   return true

#func make_visible(visible):
#	if visible:
#		screen_instance.show()
#	else:
#		screen_instance.hide()

func get_plugin_name():
	return "Live Cards"
