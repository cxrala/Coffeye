extends Node2D
var numbers = [1,2,3,4]
var list = []
var state = 0
var level = 1 
signal off
signal on


# Called when the node enters the scene tree for the first time.
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == 0 :
		emit_signal("off")
	if state == 1 :
		emit_signal("on")
		rungame(0)
	
	

func get_number():
	var random_number = numbers[randi() % numbers.size()]
	# Returns "apple", "orange", "pear", or "banana" every time the code runs.
	# We may get the same fruit multiple times in a row.
	return random_number
func rungame(level):
	ready

func generatearray(a: int,c):
	if a == 0 :
		return c
	if a != 0 :
		for i in range(100):
			generatearray(a-1, c.append(get_number))
	
