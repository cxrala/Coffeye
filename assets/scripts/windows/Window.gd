extends Control
class_name GameWindow

var dragging = false
var off = Vector2 (0,0)
@export var windowSize = Vector2 (176, 128)
@export var windowTopLeftCorner = Vector2 (0, 0)
@export var desktopSize = Vector2 (352, 204)
@export var desktopTopLeftCorner = Vector2 (16, 12)
# Called when the node enters the scene tree for the first time.

@export var overWindow : TextureButton
@export var bar : TextureButton

func _ready():
	position = Vector2 (0, 0)
	if bar:
		bar.button_down.connect(_on_bar_down)
		bar.button_up.connect(_on_bar_up)
	else:
		print("Missing window bar")
	visible = false
	set_processing_subtree(false, false)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		position = (0.2 * get_global_mouse_position()) - off
	if position.x + windowTopLeftCorner.x < desktopTopLeftCorner.x :
		position.x = desktopTopLeftCorner.x - windowTopLeftCorner.x
	elif position.x + windowTopLeftCorner.x + windowSize.x > desktopTopLeftCorner.x + desktopSize.x :
		position.x = desktopTopLeftCorner.x + desktopSize.x - windowTopLeftCorner.x - windowSize.x
	if position.y + windowTopLeftCorner.y < desktopTopLeftCorner.y :
		position.y = desktopTopLeftCorner.y - windowTopLeftCorner.y
	elif position.y + windowTopLeftCorner.y + windowSize.y > desktopTopLeftCorner.y + desktopSize.y :
		position.y = desktopTopLeftCorner.y + desktopSize.y - windowTopLeftCorner.y - windowSize.y
	
func refocus(newTopOldZ : int, top : int):
	if (z_index > newTopOldZ):
		z_index -= 1
		if (visible):
			set_processing_subtree(true, false)
		#set_process_input(true)
		#set_process_unhandled_input(true)
		#set_process_unhandled_key_input(true)
	elif (z_index == newTopOldZ):
		z_index = top
		if (visible):
			set_processing_subtree(true, true)

func _on_bar_down():
	dragging = true
	off = (0.2 * get_global_mouse_position()) - position

func _on_bar_up():
	dragging = false

func _on_taskbar_button_pressed():
	visible = !visible;
	if (visible):
		overWindow.button_down.emit()
		set_processing_subtree(true, true)
	else:
		set_processing_subtree(false, false)

func set_processing(node : Node, processing : bool, inputProcessing : bool):
	node.set_process(processing)
	node.set_process_input(inputProcessing)
	node.set_process_internal(processing)
	node.set_process_unhandled_input(inputProcessing)
	node.set_process_unhandled_key_input(inputProcessing)

func set_processing_subtree(processing : bool, inputProcessing : bool):
	var nodeQueue : Array[Node]
	nodeQueue = [self]
	while nodeQueue.size() != 0:
		var node : Node
		node = nodeQueue.pop_back()
		set_processing(node, processing, inputProcessing)
		nodeQueue.append_array(node.get_children())

func _minimise():
	visible = false
	set_processing_subtree(false, false)
