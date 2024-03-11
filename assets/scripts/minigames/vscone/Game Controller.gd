extends Node2D
var numbers = [0,1,2,3]
var state = 0
var level = 1 
var input = false
var array = []
var response = []
var inputpointer = 0
signal off
signal on
signal value
@export var iteration : TextureButton
@export var selection : TextureButton
@export var assignment : TextureButton
@export var haskell : TextureButton
@export var sequencetimer : Timer
@export var buttons : Array

func _ready():
	response = []
	startinput()

func startgame():
	emit_signal("on")
	array = []
	rungame(0)
		
func checkinput(a:int, b: Array):
	if a == b[inputpointer] :
		if inputpointer == b.size() :
			inputpointer = 0
			noinput()
			rungame(b.size() + 1)
		elif inputpointer < b.size() :
			inputpointer = inputpointer + 1
			noinput()
			takeinput()
			
	
func _process(delta):
	if state == 0 :
		emit_signal("off")

func get_number():
	var random_number = numbers[randi() % numbers.size()]
	# Returns "apple", "orange", "pear", or "banana" every time the code runs.
	# We may get the same fruit multiple times in a row.
	return random_number
	
func rungame(level):
	appendtoarray(1, array)
	var pointer = 0 
	makeglow(array,pointer)
	
func makeglow(array, pointer) :
	if pointer == array.size() :
		takeinput()
	elif pointer < array.size() :
		emit_signal("value", array[pointer])
		sequencetimer.timeout.connect(func() : makeglow(array, pointer + 1))
	
func noinput():
	input = false
	for i in range(buttons.size()):
		buttons[i].pressed.disconnect(response[i]);
	
func startinput():
	for i in range(buttons.size()):
		response.append(startgame)
		buttons[i].pressed.connect(response[i])

func takeinput():
	input = true
	for i in range(buttons.size()):
		buttons[i].pressed.connect(func() : checkinput(i, array));
	
func appendtoarray(a: int,c: Array):
	for i in range(a):
		c.append(get_number())
	return
	
