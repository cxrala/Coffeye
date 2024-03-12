extends MinigameController

@export var pipeScene : PackedScene

@export var mouse : Mouse

@export var pipeSpeed = 50

@export var spawnTime = 1

@export var upperRange = 48
@export var lowerRange = 104

@export var autoJumpThresh = 80

@export var linkNames = ["https://unhelpfulsite.co.ns", 
"https://irrelevantpage.co.ns", 
"https://technicalwiki.co.ns", 
"https://en.confusingblog.co.ns",
"https://a.wasteoftime.co.ns",
"https://surprise.distraction.co.ns"]

@export var pipeGap = Vector2(8, 16)

@export var upperY = 28
@export var lowerY = 124

@export var scoreRect : ColorRect

var rangeRange;
var minRange;

var modulatedSpawnTime = 1

var timeToSpawn = 0;

var started = false
var can_start = false

var pipes : Array[Pipe]

# Called when the node enters the scene tree for the first time.
func _ready():
	#super()._ready()
	scoreRect.size.x = 0
	rangeRange = abs(lowerRange - upperRange)
	minRange = min(lowerRange, upperRange)
	#start_game()
	pass # Replace with function body.

func start_game():
	progress = 0
	can_start = true
	
func start_play():
	scoreRect.size.x = 0
	progress = 0
	started = true
	can_start = false
	timeToSpawn = modulatedSpawnTime
	
func end_game():
	started = false
	timeToSpawn = 0

func game_over():
	end_game()
	mouse.flashing = true

func flap_input():
	if (!started && can_start):
		start_play()
	if (can_start || started):
		mouse.flap()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	if (started && timeToSpawn > 0) :
		timeToSpawn -= delta
		if (timeToSpawn < 0):
			# Spawn pipe
			var pipe : Pipe
			pipe = pipeScene.instantiate()
			pipes.append(pipe)
			var yPos = randi() % rangeRange + minRange
			pipe.position.x = 100
			pipe.position.y = yPos
			pipe.virtual_position.x = 100
			pipe.virtual_position.y = yPos
			pipe.setPipeLabels(linkNames[randi() % linkNames.size()], linkNames[randi() % linkNames.size()])
			pipe.set_spacing(pipeGap)
			add_child(pipe)
			if (started):
				timeToSpawn = modulatedSpawnTime
			else:
				timeToSpawn = 0
	var temp : Array[Pipe]
	temp = []
	for pipe in pipes:
		pipe.virtual_position.x -= delta * pipeSpeed
		if (started):
			if (pipe.position.x + pipeGap.x + mouse.mouseRadius > mouse.get_centre().x && mouse.get_centre().x >= pipe.position.x + pipeGap.x):
				var xdiff = pipe.position.x + pipeGap.x - mouse.get_centre().x
				var ydiff1 = pipe.position.y + pipeGap.y - mouse.get_centre().y
				var ydiff2 = pipe.position.y - pipeGap.y - mouse.get_centre().y
				if (xdiff * xdiff + ydiff1 * ydiff1 < mouse.mouseRadius * mouse.mouseRadius || xdiff * xdiff + ydiff2 * ydiff2 < mouse.mouseRadius * mouse.mouseRadius):
					game_over()
				pass
			elif (pipe.position.x + pipeGap.x > mouse.get_centre().x && mouse.get_centre().x > pipe.position.x):
				if (mouse.get_centre().y + mouse.mouseRadius > pipe.position.y+pipeGap.y || mouse.get_centre().y - mouse.mouseRadius < pipe.position.y-pipeGap.y):
					game_over()
			elif (pipe.position.x >= mouse.get_centre().x && mouse.get_centre().x > pipe.position.x - mouse.mouseRadius):
				var xdiff = pipe.position.x - mouse.get_centre().x
				var ydiff1 = pipe.position.y + pipeGap.y - mouse.get_centre().y
				var ydiff2 = pipe.position.y - pipeGap.y - mouse.get_centre().y
				if (xdiff * xdiff + ydiff1 * ydiff1 < mouse.mouseRadius * mouse.mouseRadius || xdiff * xdiff + ydiff2 * ydiff2 < mouse.mouseRadius * mouse.mouseRadius):
					game_over()
				pass
		
		if (started && !pipe.scored && pipe.virtual_position.x + pipeGap.x < mouse.get_centre().x - mouse.mouseRadius):
			progress += 1
			scoreRect.size.x = (progress * 84 / target)
			pipe.scored = true
		if pipe.virtual_position.x < -100:
			remove_child(pipe)
		else:
			temp.append(pipe)
	pipes = temp
	if (started):
		if (mouse.position.y + mouse.mouseRadius > lowerY || mouse.position.y - mouse.mouseRadius < upperY):
			game_over()
	else:
		if (pipes.size() == 0 && mouse.position.y > autoJumpThresh - 16 && mouse.position.y < autoJumpThresh):
			if (progress >= target):
				finished_task_event.emit()
			else:
				can_start = true
			mouse.flashing = false
		if (mouse.position.y > autoJumpThresh):
			mouse.flap()
			pass
		pass
	pass
