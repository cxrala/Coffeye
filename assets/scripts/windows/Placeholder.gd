extends Sprite2D
var active = false
var dif = Vector2(0, 0)

func _process(_delta):
	var mouse_position = get_viewport().get_mouse_position()
	if active:	
		$Player.global_position = mouse_position + dif

func _on_Button_button_down():
	dif = $Player.get_global_position() - get_viewport().get_mouse_position()
	active = true

func _on_Button_button_up():
	active = false
