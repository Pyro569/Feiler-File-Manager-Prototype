extends Area3D

var output = []
var lastClick

# File class
var file
var FilesDropdown = preload("filesDropdown.gd")
var prevKeyBackspace
var lastLeftClickTime = 10000

# for testing,
	#_init(Directory.new("fake_file.exe", 2, "C:/"))

func setFile(file):
	self.file = file
	#print(get_node_or_null("CollisionShape3D/" + str(file.type)))
	get_node("CollisionShape3D/" + str(file.type)).show()

func _init():
	pass

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
				# Double-click opens file
				if(Time.get_ticks_msec() - lastLeftClickTime < 500):
					get_node("/root/Node3D/dropdown").open(file)
					print("left click")
					lastLeftClickTime = 1000
				lastLeftClickTime = Time.get_ticks_msec()
			# Right click
			if(event.button_mask == 2):
				print("set dropdown")
				get_node("/root/Node3D/dropdown").setToNewFile(file, get_viewport().get_mouse_position(), get_path())
	lastClick = event.button_mask
	#OS.execute("CMD.exe", ["/C", "cd C:/ && START powershell.exe"], output, true, true)
