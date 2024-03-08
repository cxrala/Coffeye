extends Button
func _ready():
	$Placeholder.visible = false
# Called when the node enters the scene tree for the first time.
func _pressed():
	print("hi")
	$Placeholder.visible = !$Placeholder.visible
