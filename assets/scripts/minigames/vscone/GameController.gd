extends Node2D
var numbers = [0,1,2,3]
var state = 0
var level = 1 
var input = false
var array = []
var response = []
var inputpointer = 0
var flashpointer = 0
signal off
signal on
signal value
@export var iteration : TextureButton
@export var selection : TextureButton
@export var assignment : TextureButton
@export var haskell : TextureButton
@export var sequencetimer : Timer
@export var buttons : Array[VsconeButton]

func _ready():
	response = []
	sequencetimer.timeout.connect(makeglow)
	startinput()

func startgame():
	emit_signal("on")
	array = []
	rungame(1)
		
func checkinput(a:int):
	if a == array[inputpointer] :
		if inputpointer == array.size() - 1 :
			inputpointer = 0
			noinput()
			rungame(array.size() + 1)
		elif inputpointer < array.size() :
			noinput()
			inputpointer = inputpointer + 1
			takeinput()
	else:
		restart_attempt()
			
func restart_attempt():
	inputpointer = 0
	noinput()
	startsequence()
	pass

func _process(delta):
	if state == 0 :
		emit_signal("off")

func get_number():
	var random_number = numbers[randi() % numbers.size()]
	# Returns "apple", "orange", "pear", or "banana" every time the code runs.
	# We may get the same fruit multiple times in a row.
	return random_number
	
func rungame(level : int):
	appendtoarray(level - array.size(), array)
	startsequence()
	
func disable_all():
	for button in buttons:
		button.set_enabled(false)
		
func enable_all():
	for button in buttons:
		button.set_enabled(true)
	
func startsequence():
	disable_all()
	flashpointer = 0
	makeglow()
	
func makeglow() :
	sequencetimer.stop()
	if flashpointer == array.size() :
		inputpointer = 0
		noinput()
		enable_all()
		takeinput()
	elif flashpointer < array.size() :
		buttons[array[flashpointer]].sequentialglow(array[flashpointer])
		flashpointer += 1
		sequencetimer.start(0.5)
	
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
		response[i] = func() : checkinput(i)
		buttons[i].pressed.connect(response[i]);
	
func appendtoarray(a: int,c: Array):
	for i in range(a):
		c.append(get_number())
	return
	
