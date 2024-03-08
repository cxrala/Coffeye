extends Node2D
var timer = 0
func _on_coffee_button_pressed():
	timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$EyeAnimator.play("eye1")
	pass # Replace with function body.
	
func _process(delta):
	if timer == 6 :
		get_tree().change_scene_to_file("res://assets/scenes/GameOver.tscn")
	
func _on_timer_timeout():
	print (timer)
	timer = timer + 1 # Replace with function body.
	if timer == 0 :
		$EyeAnimator.play("eye1")
	else: if timer == 1 :
		$EyeAnimator.play("eye2")
	else: if timer == 2 :
		$EyeAnimator.play("eye3")
	else: if timer == 3 :
		$EyeAnimator.play("eye4")
	else: if timer == 4 :
		$EyeAnimator.play("eye5")
	else: if timer == 5 :
		$EyeAnimator.play("eye6")

