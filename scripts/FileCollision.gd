extends Area3D

var output = []
var lastClick

# File class
var file
var FilesDropdown = preload("filesDropdown.gd")

# This will be initialized by the fileDroppedDown
func _init(file):
	self.file = file

func _on_mouse_entered():
	print("mouse entered")
	pass # Replace with function body.

func _on_mouse_exited():
	print("mouse exited")


func _on_input_event(camera, event, position, normal, shape_idx):
	print("input event", event.button_mask)
	
	# If any button on the mouse is pressed
	if(event.button_mask > 0):
		print("asdasdasdasdasd")
		# Do this because you can click and drag your mouse around on the object and it will keep on calling this
		if(event.button_mask != lastClick):
			# Left click
			if(event.button_mask == 1):
				print("left click")
			# Right click
			if(event.button_mask == 2):
				print("new")
				FilesDropdown.new(file, global_position)
		lastClick = event.button_mask
	#OS.execute("CMD.exe", ["/C", "cd C:/ && START powershell.exe"], output, true, true)
	
