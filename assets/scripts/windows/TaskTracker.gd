extends GameWindow
class_name TaskTrackerWindow

@export var minigames : Array[MinigameWindow]

@export var tasks : Array[TaskTuple]
@export var taskDisplays : Array[Task]
@export var taskPrefab : PackedScene

@export var minigameIcons : Array[Texture2D]

var currentTask = {}

@export var taskSection : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	for i in range(minigames.size()):
		minigames[i].taskComplete.connect(func(): _process_task_complete(i))
		minigames[i].taskProgress.connect(func(): _process_task_progress(i))
	
	for i in range(tasks.size()):
		var task = tasks[i]
		var taskDisplay : Task
		taskDisplay = taskPrefab.instantiate()
		taskDisplay.setup(task, minigameIcons)
		taskDisplays.append(taskDisplay)
		if (i > 0):
			taskDisplays[i - 1].below = taskDisplays[i]
			taskDisplays[i].above = taskDisplays[i - 1]
		
		taskSection.add_child(taskDisplay)
		
		if (!currentTask.has(task.game)):
			currentTask[task.game] = i
			minigames[task.game].set_task(task)
			
	if taskDisplays.size() > 0:
		taskDisplays[0].position = Vector2 (0,0)
		if (taskDisplays.size() > 1):
			taskDisplays[1]._updatePosition()

func _process_task_progress(game : int):
	if (currentTask.has(game)):
		taskDisplays[currentTask[game]]._updateCompletion()

func _process_task_complete(game : int):
	if (currentTask.has(game)):
		taskDisplays[currentTask[game]]._updateCompletion()
		currentTask.erase(game)
		for i in range(tasks.size()):
			var task = tasks[i]
			if (task.game == game && !task.complete):
				currentTask[game] = i
				minigames[game].set_task(task)
				break
				
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float):
	super._process(delta)
	pass
