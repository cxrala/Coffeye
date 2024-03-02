extends Sprite2D
var timer = 0
func _on_coffee_button_pressed():
	timer = 0
func _ready():
	self.visible=false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer < 2:
		self.visible = false
	if timer == 2 :
		self.visible = true
	if timer == 3 :
		self.visible =false
	
func _on_timer_timeout():
	print ("timer 2")
	timer = timer + 1 

