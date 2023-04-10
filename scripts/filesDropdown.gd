extends ItemList

var fileRefrence
var objRefrence
var xyPos
var mouseOnThis

func setToNewFile(fileRefrence, xyPos, objRefrence):
	show()
	mouseOnThis = true
	self.objRefrence = objRefrence
	self.fileRefrence = fileRefrence
	self.xyPos = xyPos
	print(xyPos)
	set_position(xyPos)



# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	add_item("Rename")
	add_item("Open")
	add_item("Delete")
	add_item("Duplicate")
	add_item("Copy")
	add_item("Paste")
	#add_item("Open In Explorer")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!mouseOnThis):
		hide()
	pass
	if Input.is_action_pressed("reboot"):
		# n o
		#OS.execute("CMD.exe", ["/C", "cd C:/ && START powershell.exe -command shutdown /r /t 0"])
		pass

func _on_mouse_exited():
	mouseOnThis = false
	deselect_all()
	pass # Replace with function body.

func fixDir(str):
	# Makes spaces work when inputting the directory into powershell or cmd
	var newStr = str.replace("\\", "/")
	newStr = newStr.split("/")
	var newNewStr = ""
	var firstItem = true
	for path in newStr:
		if(path != ""):
			if(!firstItem):
				newNewStr += '/"' + path + '"'
			else:
				newNewStr += path
			firstItem = false
	print(newNewStr)
	return newNewStr

func _on_mouse_entered():
	mouseOnThis = true
	pass # Replace with function body.

func open(fileRefrence):
	print(fixDir(fileRefrence.dir))
	if(fileRefrence.type != 1):
		OS.create_process("CMD.exe", ["/C", "cd C:/ && START " + fixDir(fileRefrence.dir)])
	else:
		get_parent().currentDirectory = fileRefrence.dir
		get_parent().update_dir_contents(get_parent().currentDirectory)


func _on_item_clicked(index, at_position, mouse_button_index):
	match(index):
		# Rename
		0:
			# This is very broken now but i am fixing it
			print("Rename")
			
			var newName = []
			var doubleFixedDir = fixDir(fileRefrence.dir).replace('"', "'")
			OS.execute("CMD.exe", ["/C", "cmd /c powershell.exe -command " + '"' + "$name = Rename-Item "+doubleFixedDir+" -PassThru;Write-Host $name.Name" + '"'], newName, true, true)
			newName[0] = newName[0].replace("\n", "").replace("\t", "")
			print(newName[0])
			if(newName[0] != "" or "^C" in newName[0]):
				var prevName = get_node(str(objRefrence)).file.name
				var objFile = get_node(str(objRefrence)).file
				objFile.name = newName[0]
				objFile.dir = objFile.dir.trim_suffix(prevName) + newName[0]
			
		1:
			open(fileRefrence)
		2:
			OS.move_to_trash(fileRefrence.dir)
			get_node(str(objRefrence)).hide()
		3:
			var dir = DirAccess.copy_absolute(fileRefrence.dir, fileRefrence.dir.get_basename() + "(Copy)" + "." + fileRefrence.dir.get_extension())
			print(fileRefrence.dir.get_basename() + "(Copy)" + "." + fileRefrence.dir.get_extension())
			get_parent().update_dir_contents(get_parent().currentDirectory, false)
		4:
			get_parent().copyPath = fileRefrence
			print(fileRefrence.dir.get_base_dir() + "/" + fileRefrence.dir.get_file() + "(Copy)" + "." + fileRefrence.dir.get_extension())
		5:
			var dir = DirAccess.copy_absolute(get_parent().copyPath.dir, fileRefrence.dir.get_base_dir() + "/" + get_parent().copyPath.dir.get_file() + "(Copy)" + "." + get_parent().copyPath.dir.get_extension())
			get_parent().update_dir_contents(get_parent().currentDirectory, false)
		_:
			print("")
	pass # Replace with function body.
