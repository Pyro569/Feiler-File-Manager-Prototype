extends Node

var directory = ""

class File:
	var name
	
	# 0 is unknown
	# 1 is folder
	# 2 is executable
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
var currentDirectory = "C:/Windows/"

# Updates filesInDirectory to be the files in the current directory
func update_dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		var scene = preload("res://scenes/file.tscn")
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var i = 0
		while file_name != "":
			var fileObject
			if dir.current_is_dir(): # folder
				fileObject = File.new(file_name, 1, path + file_name)
			else: # file
				var file_type = (file_name.rsplit("."))
				file_type = file_type[file_type.size() - 1]
				match file_type:
					"exe":
						fileObject = File.new(file_name, 2, path + file_name)
					_:
						fileObject = File.new(file_name, 0, path + file_name)
			filesInDirectory.push_back(fileObject)
			file_name = dir.get_next()
			var instance = scene.instantiate()
			add_child(instance)
			print("T:" + file_name)
			instance.position = Vector3(i * 2, 0, 0)
			#instance.global_position = Vector3(i * 200, 0, 0)
			instance.file = fileObject
			i += 1
			var file = FileAccess.open(path + file_name, FileAccess.READ)
			if file != null:
				instance.scale *= log(pow(file.get_length(), 0.33333333333333))
			#print(str(file) + path + file_name)
	else:
		print("An error occurred when trying to access the path.")
	
	
func _init():
	update_dir_contents(currentDirectory)
