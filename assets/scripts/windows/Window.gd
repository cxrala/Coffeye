extends Node2D
var dragging = false
var of = Vector2 (0,0)
# Called when the node enters the scene tree for the first time.

@export var bar : TextureButton

func _ready():
	if bar:
		bar.button_down.connect(_on_bar_down)
		bar.button_up.connect(_on_bar_up)
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		position = (0.2 * get_global_mouse_position()) - of

func _on_bar_down():
	dragging = true
	of = (0.2 * get_global_mouse_position()) - position

func _on_bar_up():
	dragging = false

func _on_taskbar_button_pressed():
	visible = !visible;

func _minimise():
	visible = false
