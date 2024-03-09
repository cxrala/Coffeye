extends Node2D
var numbers = [1,2,3,4]
var list = []


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(100):
		list.append(get_number()) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_number():
	var random_number = numbers[randi() % numbers.size()]
	# Returns "apple", "orange", "pear", or "banana" every time the code runs.
	# We may get the same fruit multiple times in a row.
	return random_number
