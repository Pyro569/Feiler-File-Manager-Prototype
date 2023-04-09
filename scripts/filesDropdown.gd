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
	add_item("Copy")
	add_item("Paste")
	add_item("Open In Explorer")
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
			print("Rename")
			var newName = []
			OS.execute("CMD.exe", ["/C", "cmd /c powershell.exe -command $name = Rename-Item "+fixDir(fileRefrence.dir)+" -PassThru;Write-Host $name.Name"], newName, true, true)
			newName[0] = newName[0].replace("\n", "").replace("\t", "")
			if(newName[0] != "" or newName[0] == "^C"):
				var prevName = get_node(str(objRefrence)).file.name
				var objFile = get_node(str(objRefrence)).file
				objFile.name = newName[0]
				objFile.dir = objFile.dir.trim_suffix(prevName) + newName[0]
			print(newName)
			
		1:
			open(fileRefrence)
			print("Open")
		_:
			print("")
	pass # Replace with function body.
