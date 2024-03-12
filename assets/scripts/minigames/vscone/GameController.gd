extends MinigameController

var numbers = [0,1,2,3]
var state = 0
var input = false
var array = []
var response : Array[Callable]
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

@export var scoreRect1 : ColorRect
@export var scoreRect2 : ColorRect

func _ready():
	#super()._ready()
	scoreRect1.size.y = 0
	scoreRect2.size.y = 0
	progress = 0
	sequencetimer.timeout.connect(makeglow)
	disable_all()
	response = []
	for i in range(len(buttons)):
		response.append(startinput)

func reset():
	scoreRect1.size.y = 0
	scoreRect2.size.y = 0
	progress = 0
	sequencetimer.timeout.connect(makeglow)
	disable_all()

func start_game():
	startinput()
	
func start_play():
	state = 1
	emit_signal("on")
	array = []
	progress = 1
	rungame()
		
func checkinput(a:int):
	if a == array[inputpointer] :
		if inputpointer == array.size() - 1 :
			scoreRect2.size.y = 119 * (inputpointer + 1) / target
			inputpointer = 0
			noinput()
			if (progress >= target):
				finished_task_event.emit()
				reset()
			else:
				progress = array.size() + 1
				rungame()
		elif inputpointer < array.size() :
			scoreRect2.size.y = 119 * (inputpointer + 1) / target
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
	super._process(delta)
	if state == 0 :
		emit_signal("off")

func get_number():
	var random_number = numbers[randi() % numbers.size()]
	# Returns "apple", "orange", "pear", or "banana" every time the code runs.
	# We may get the same fruit multiple times in a row.
	return random_number
	
func rungame():
	appendtoarray(progress - array.size(), array)
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
		scoreRect1.size.y = 119 * progress / target
		scoreRect2.size.y = 119 * inputpointer / target
		noinput()
		enable_all()
		takeinput()
	elif flashpointer < array.size() :
		buttons[array[flashpointer]].sequentialglow(array[flashpointer])
		flashpointer += 1
		sequencetimer.start(0.5)
	
func noinput():
	input = false
	if (response.size() != 0):
		for i in range(buttons.size()):
			buttons[i].pressed.disconnect(response[i]);
	
func startinput():
	for i in range(buttons.size()):
		response[i] = start_play
		buttons[i].pressed.connect(response[i])
		buttons[i].startglow()

func takeinput():
	input = true
	for i in range(buttons.size()):
		response[i] = func() : checkinput(i)
		buttons[i].pressed.connect(response[i]);
	
func appendtoarray(a: int,c: Array):
	for i in range(a):
		c.append(get_number())
	return
	
