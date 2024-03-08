extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_cone_button_button_down():
	self.visible = true # Replace with function body.


func _on_cone_button_button_up():
	self.visible= false # Replace with function body.
