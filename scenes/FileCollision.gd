extends Area3D

var output = []

func _on_mouse_entered():
	print("mouse entered")
	pass # Replace with function body.

func _on_mouse_exited():
	print("mouse exited")


func _on_input_event(camera, event, position, normal, shape_idx):
	print("input event", event)
	#OS.execute("C:\\Windows\\System32\\WindowsPowerShell\\v1.0l\\powershell.exe", args, [], true)
	OS.execute("CMD.exe", ["/C", "cd C:/ && START powershell.exe"], output, true, true)
	print(output)



