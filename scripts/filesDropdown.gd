extends ItemList

var fileRefrence
var xyPos

func _init(fileRefrence, xyPos):
	self.fileRefrence = fileRefrence
	self.xyPos = xyPos
	set_position(xyPos)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_item("Rename")
	add_item("Open")
	add_item("Open with...")
	add_item("Bookmark")
	add_item("Open In Explorer")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
