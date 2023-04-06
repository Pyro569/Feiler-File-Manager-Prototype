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
			print("test")
			self.size = 1
		
	
	func openInExplorer():
		# TODO: this will open the path to the file in file explorer
		pass
	
	func rename(name):
		# TODO: this will update the real name in the file too
		self.name = name
	
# includes folders too
var filesInDirectory = []
var currentDirectory = "C:/"

# Updates filesInDirectory to be the files in the current directory
func update_dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				
				filesInDirectory.push_back(File.new(file_name, 1, path + file_name))
			else:
				var file_type = (file_name.rsplit("."))
				file_type = file_type[file_type.size() - 1]
				match file_type:
					"exe":
						filesInDirectory.push_back(File.new(file_name, 2, path + file_name))
					_:
						filesInDirectory.push_back(File.new(file_name, 0, path + file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
