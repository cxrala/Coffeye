extends Node2D
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible= true # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

	


func _on_timer_timeout():
	print ("timer 0")
	timer = timer + 1 
	if timer == 5 :
		get_tree().change_scene_to_file("res://GameOver.tscn") # Replace with function body.
