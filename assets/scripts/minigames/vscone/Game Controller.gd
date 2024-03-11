extends Node2D
var numbers = [1,2,3,4]
var list = []
var state = 0
var level = 1 
signal off
signal on
@export var iteration : TextureButton
@export var selection : TextureButton
@export var assignment : TextureButton
@export var haskell : TextureButton

func _ready():
	iteration.pressed.connect(func(): inputvalue(0))
	selection.pressed.connect(func(): inputvalue(1))
	assignment.pressed.connect(func(): inputvalue(2))
	haskell.pressed.connect(func(): inputvalue(3))
# Called when the node enters the scene tree for the first time.
	 # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func inputvalue(a):
	if state == 0 :
		state == 1
		emit_signal("on")
		rungame(0)
	
func _process(delta):
	if state == 0 :
		emit_signal("off")

func get_number():
	var random_number = numbers[randi() % numbers.size()]
	# Returns "apple", "orange", "pear", or "banana" every time the code runs.
	# We may get the same fruit multiple times in a row.
	return random_number
func rungame(level):
	ready

func appendtoarray(a: int,c: Array):
	for i in range(a):
		c.append(get_number)
	return
	
