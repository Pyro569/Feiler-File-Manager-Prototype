extends ItemList

var fileRefrence
var xyPos
var mouseOnThis

func setToNewFile(fileRefrence, xyPos):
	show()
	mouseOnThis = true
	self.fileRefrence = fileRefrence
	self.xyPos = xyPos
	print(xyPos)
	set_position(xyPos)



# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	add_item("Rename")
	add_item("Open")
	add_item("Open with...")
	add_item("Bookmark")
	add_item("Open In Explorer")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!mouseOnThis):
		hide()
	pass
	if Input.is_action_pressed("reboot"):
		OS.execute("CMD.exe", ["/C", "cd C:/ && START powershell.exe -command shutdown /r /t 0"])

func _on_mouse_exited():
	mouseOnThis = false
	deselect_all()
	pass # Replace with function body.


func _on_mouse_entered():
	mouseOnThis = true
	pass # Replace with function body.


func _on_item_clicked(index, at_position, mouse_button_index):
	match(index):
		# Rename
		0:
			print("Rename")
			OS.execute("CMD.exe", ["/C", "cd C:/ && START powershell.exe -command Rename-Item "+fileRefrence.dir+" "])
		1:
			print(fileRefrence.type)
			if(fileRefrence.type != 1):
				OS.create_process("CMD.exe", ["/C", "cd C:/ && START " + fileRefrence.dir])
			else:
				get_parent().currentDirectory = fileRefrence.dir
				# Remove all previous files
				var children = get_parent().get_children()
				for child in children:
					if "File" in child.name:
						child.queue_free()
				get_parent().update_dir_contents(get_parent().currentDirectory)
			print("Open")
		_:
			print("")
	pass # Replace with function body.
