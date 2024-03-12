extends Control

@export var windows : Array[GameWindow]
signal refocus

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(windows.size()):
		move_child(windows[i], windows.size()-1)
		windows[i].pressed.connect(func() : refocus_windows(i))
		windows[i].z_index = i
	pass # Replace with function body.

func refocus_windows(windowNum : int):
	print("Refocusing:")
	print(windowNum)
	var oldZ = windows[windowNum].z_index
	var newZ = windows.size()
	move_child(windows[windowNum], windows.size()-1)
	for window in windows:
		window.refocus(oldZ, newZ)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
