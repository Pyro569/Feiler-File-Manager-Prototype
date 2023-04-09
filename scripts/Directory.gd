extends Node

var directory = ""
var os = OS.get_name()
var username = OS.get_environment("USERNAME")
var copyPath

class File:
	var name
	
	# 0 is unknown
	# 1 is folder
	# 2 is executable
	# 3 is a zip
	# 4 is a graphics file
	# 5 is a text document
	var type
	
	# Size in KB
	# TODO:
	var size
	var dir
	
	func _init(name, type, dir):
		self.name = name
		self.type = type
		self.dir = dir
		var file = FileAccess.open(dir + name, FileAccess.READ)
		if type == 1:
			dir += "/"
		if file != null:
			self.size = file.get_length() / 1000
		else:
			#print("test")
			self.size = 1
		
	
	func openInExplorer():
		# TODO: this will open the path to the file in file explorer
		pass
	
	func rename(name):
		# TODO: this will update the real name in the file too
		self.name = name
	
# includes folders too
var filesInDirectory = []
var currentDirectory = "C:/Users/" + username + "/"

func removeFileNodes(reset_pos):
	# Remove all previous files and reset position
	var children = get_children()
	for child in children:
		if "File" in child.name:
			child.queue_free()
	if(get_node_or_null("/root/Node3D/CharacterBody3D") != null):
		if(reset_pos):
			get_node("/root/Node3D/CharacterBody3D").global_position = Vector3(0, 0, 0)

func sortFiles(toSort):
	var children = get_children()
	print(toSort)
	for child in children:
		if "File" in child.name:
			if(!(toSort in child.file.name) and toSort != ""):
				child.hide()
			else:
				child.show()

func resolve_size(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file != null:
		return file.get_length()
	else:
		var output = [10]
		#OS.execute("powershell.exe", ["(ls -r " + path + " | measure -sum Length).sum"], output)
		#print(path, ": ", output[0])
		return int(output[0])
		#var dir = DirAccess.open(path)
		#if dir:
		#	dir.list_dir_begin()
		#	var size = 0
		#	var file_name = dir.get_next()
		#	while file_name != "":
		#		#print(path + "/" + file_name)
		#		size += resolve_size(path + "/" + file_name)
		#		file_name = dir.get_next()
		#	return size
		#else:
		#	return -1

# Updates filesInDirectory to be the files in the current directory
func update_dir_contents(path, reset_pos=true):
	removeFileNodes(reset_pos)
	var dir = DirAccess.open(path)
	if(get_node_or_null("/root/Node3D/DirEdit") != null):
		get_node_or_null("/root/Node3D/DirEdit").text = currentDirectory
	if dir:
		var scene = preload("res://scenes/file.tscn")
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var i = 0
		while file_name != "":
			var fileObject
			if dir.current_is_dir(): # folder
				fileObject = File.new(file_name, 1, path + file_name + "/")
			else: # file
				var file_type = (file_name.rsplit("."))
				file_type = file_type[file_type.size() - 1]
				match file_type:
					"exe":
						fileObject = File.new(file_name, 2, path + file_name)
					"zip":
						fileObject = File.new(file_name, 3, path + file_name)
					"png":
						fileObject = File.new(file_name, 4, path + file_name)
					"jpg":
						fileObject = File.new(file_name, 4, path + file_name)
					"jpeg":
						fileObject = File.new(file_name, 4, path + file_name)
					"svg":
						fileObject = File.new(file_name, 4, path + file_name)
					"txt":
						fileObject = File.new(file_name, 5, path + file_name)
					_:
						fileObject = File.new(file_name, 0, path + file_name)
			filesInDirectory.push_back(fileObject)
			var instance = scene.instantiate()
			add_child(instance)
			instance.position = Vector3(i * 3, 0, 0)
			#instance.global_position = Vector3(i * 200, 0, 0)
			instance.setFile(fileObject)
			instance.scale *= clamp(log(pow(resolve_size(path + file_name), 0.333333333333)), 0.5, 100000000)
			#print(str(file) + path + file_name)
			file_name = dir.get_next()
			i += 1
	else:
		OS.alert("An error occurred when trying to access the path.")
	currentDirectory = currentDirectory.replace("\\", "/")

func _init():
	if OS.get_name() == "Linux":
		currentDirectory = "/"
	update_dir_contents(currentDirectory)
