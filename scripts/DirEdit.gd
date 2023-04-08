extends TextEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	text = get_parent().currentDirectory
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_gui_input(event):
	# Set directory to input 
	if(event.get_class() == "InputEventKey"):
		if(event.pressed):
			# If enter key
			if(event.keycode == 4194309):
				if(text.right(1) != "/"):
					text += "/"
				get_parent().currentDirectory = text
				release_focus()
				get_parent().update_dir_contents(text)
				print(event)
