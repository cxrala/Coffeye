extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = true # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# Replace with function body.


func _on_iteration_button_button_down():
	self.visible = false  # Replace with function body.


func _on_iteration_button_button_up():
	self.visible=true# Replace with function body.
