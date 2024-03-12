extends Node2D

@export var animLevels = 6
@export var playerState : PlayerState
var lastLevel = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$EyeAnimator.play("eye1")
	pass # Replace with function body.
	
func _process(delta):
	var level = floori(playerState.get_exhaustion() * animLevels)
	if (level != lastLevel):
		lastLevel = level
		update_anim()

func update_anim():
	if lastLevel == 0 :
		$EyeAnimator.play("eye1")
	else: if lastLevel == 1 :
		$EyeAnimator.play("eye2")
	else: if lastLevel == 2 :
		$EyeAnimator.play("eye3")
	else: if lastLevel == 3 :
		$EyeAnimator.play("eye4")
	else: if lastLevel == 4 :
		$EyeAnimator.play("eye5")
	else: if lastLevel == 5 :
		$EyeAnimator.play("eye6")
