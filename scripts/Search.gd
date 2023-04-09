extends TextEdit

var mouseOnThis = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.get_mouse_mode() == 2):
		release_focus()
	pass


func _on_mouse_entered():
	mouseOnThis = true


func _on_mouse_exited():
	mouseOnThis = false

func _input(event):
	if event is InputEventMouseButton and mouseOnThis == false:
		release_focus()


func _on_text_changed():
	get_parent().sortFiles(text)
	pass # Replace with function body.
