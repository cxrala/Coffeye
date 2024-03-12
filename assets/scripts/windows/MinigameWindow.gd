extends GameWindow
class_name MinigameWindow

@export var targets = [2, 3]
@export var minigameController : MinigameController
@export var taskIndex = 0
@export var task : TaskTuple

signal taskComplete
signal taskProgress

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	minigameController.finished_task_event.connect(_complete_task);
	_check_start_task()
	pass # Replace with function body.

func _check_start_task():
	if (taskIndex < targets.size()):
		minigameController.target = targets[taskIndex]
		minigameController.start_game()
	elif (taskIndex == targets.size()):
		task.complete = true
		taskComplete.emit()

func set_task(newTask : TaskTuple):
	targets = newTask.targets
	taskIndex = 0
	task = newTask
	_check_start_task()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	pass

func _complete_task():
	taskIndex += 1
	if task:
		task.progress = taskIndex
		#print("Window task progress: %d" % task.progress)
		taskProgress.emit()
	_check_start_task()
