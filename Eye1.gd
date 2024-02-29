extends Sprite2D
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible=true # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer > 1 :
		self.visible = false
	


func _on_timer_timeout():
	print ("hi")
	timer = timer + 1 # Replace with function body.
