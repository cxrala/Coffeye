extends Button

# Called when the node enters the scene tree for the first time.
func _pressed():
	print("hi")
	$Placeholder.visible = !$Placeholder.visible
