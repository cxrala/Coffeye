extends Node2D
var timer = 0
func _on_coffee_button_pressed():
	timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if timer == 0 :
		$Eye1.visible = true
	if timer == 1 :
		$Eye1.visible = false
		$Eye2.visible = true
	if timer < 1 :
		$Eye2.visible = false
	if timer == 2 :
		$Eye2.visible =false
		$Eye3.visible = true
	if timer < 2:
		$Eye3.visible = false
	if timer == 3 :
		$Eye3.visible =false
		$Eye4.visible = true
	if timer < 3 :
		$Eye4.visible = false
	if timer == 4 :
		$Eye4.visible =false
		$Eye5.visible = true
	if timer < 4 :
		$Eye5.visible = false
	if timer == 5 :
		$Eye5.visible =false
		get_tree().change_scene_to_file("res://GameOver.tscn")
	
func _on_timer_timeout():
	print (timer)
	timer = timer + 1 # Replace with function body.

