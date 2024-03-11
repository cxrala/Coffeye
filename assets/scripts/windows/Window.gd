extends Node2D
var dragging = false
var off = Vector2 (0,0)
@export var windowSize = Vector2 (176, 128)
@export var windowTopLeftCorner = Vector2 (-88, -4)
@export var desktopSize = Vector2 (352, 204)
@export var desktopTopLeftCorner = Vector2 (16, 12)
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
		position = (0.2 * get_global_mouse_position()) - off
	if position.x + windowTopLeftCorner.x < desktopTopLeftCorner.x :
		position.x = desktopTopLeftCorner.x - windowTopLeftCorner.x
	elif position.x + windowTopLeftCorner.x + windowSize.x > desktopTopLeftCorner.x + desktopSize.x :
		position.x = desktopTopLeftCorner.x + desktopSize.x - windowTopLeftCorner.x - windowSize.x
	if position.y + windowTopLeftCorner.y < desktopTopLeftCorner.y :
		position.y = desktopTopLeftCorner.y - windowTopLeftCorner.y
	elif position.y + windowTopLeftCorner.y + windowSize.y > desktopTopLeftCorner.y + desktopSize.y :
		position.y = desktopTopLeftCorner.y + desktopSize.y - windowTopLeftCorner.y - windowSize.y
	

func _on_bar_down():
	dragging = true
	off = (0.2 * get_global_mouse_position()) - position

func _on_bar_up():
	dragging = false

func _on_taskbar_button_pressed():
	visible = !visible;

func _minimise():
	visible = false
