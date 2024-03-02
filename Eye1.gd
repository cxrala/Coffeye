extends Sprite2D
var timer = 0
func _on_coffee_button_pressed():
	timer = 0

func _ready():
	self.visible= true 


func _process(delta):
	if timer == 0 :
		self.visible = true
	if timer == 1 :
		self.visible = false
	
func _on_timer_timeout():
	print ("timer 0")
	timer = timer + 1 # Replace with function body.


 # Replace with function body.
