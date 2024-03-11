extends Sprite2D
var dragging = false
var of = Vector2 (0,0)
# Called when the node enters the scene tree for the first time.

func _ready():
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		position = (0.2 * get_global_mouse_position()) - of

func _on_button_button_down():
	dragging = true # Replace with function body.
	of = (0.2 * get_global_mouse_position()) - position


func _on_button_button_up():
	dragging = false # Replace with function body.


func _on_cone_button_pressed():
	visible = !visible;
