extends Node

var directory = ""

class File:
	var name
	
	# 0 is unknown
	# 1 is folder
	# 2 is executable
	var type
	
	# Size in MB
	# TODO:
	var size
	var dir
	
	func _init(name, type, dir):
		self.name = name
		self.type = type
		self.size = 1
		self.dir = dir
	
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
