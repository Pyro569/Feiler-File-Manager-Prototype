extends Area3D

var output = []
var lastClick

# File class
var file
var FilesDropdown = preload("filesDropdown.gd")

# for testing,
	#_init(Directory.new("fake_file.exe", 2, "C:/"))

func setFile(file):
	self.file = file

func _init():
	# for testing,
	setFile(Directory.File.new("file.png", 2, "res://assets/"))
	print(file.size)
	print(scale, position)
	scale *= file.size
	#position /= file.size
	print(scale, position)

func _on_mouse_entered():
	pass # Replace with function body.

func _on_mouse_exited():
	pass
	


func _on_input_event(camera, event, position, normal, shape_idx):
	# If any button on the mouse is pressed
	if(event.button_mask > 0):
		# Do this because you can click and drag your mouse around on the object and it will keep on calling this
		if(event.button_mask != lastClick):
			# Left click
			if(event.button_mask == 1):
				print("left click")
			# Right click
			if(event.button_mask == 2):
				print("set dropdown")
				get_node("/root/Node3D/dropdown").setToNewFile(file, get_viewport().get_mouse_position())
	lastClick = event.button_mask
	#OS.execute("CMD.exe", ["/C", "cd C:/ && START powershell.exe"], output, true, true)
