extends GameWindow

@export var tasks = [2, 3]
@export var minigameController : MinigameController

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	minigameController.finished_task_event.connect(_complete_task);
	_check_start_task()
	pass # Replace with function body.

func _check_start_task():
	if (tasks.size() != 0):
		minigameController.target = tasks[0]
		minigameController.start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	pass

func _complete_task():
	print("Finished Task")
	tasks.pop_front()
	_check_start_task()
