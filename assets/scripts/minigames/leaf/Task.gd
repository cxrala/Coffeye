extends Node2D
class_name Task

const margin = 2

@export var task : TaskTuple
@export var iconSprite : Sprite2D
@export var base : ColorRect
@export var completionBar : ColorRect
@export var label : RichTextLabel
@export var above : Task
@export var below : Task

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func setup(newTask : TaskTuple, minigameIcons : Array[Texture2D]):
	task = newTask
	iconSprite.texture = minigameIcons[task.game]
	_updateCompletion()

func _updateCompletion():
	#print("Task display progress: %d" % task.progress)
	completionBar.size.x = base.size.x * task.progress / task.targets.size()
	if task.complete:
		label.text = ("[s]" + task.name + ": %d / %d[/s]" % [task.progress, task.targets.size()])
		print("Label text: " + label.text)
	else:
		label.text = (task.name + ": %d / %d" % [task.progress, task.targets.size()])
		print("Label text: " + label.text)
	if below:
		below._updatePosition()

func _get_lowest():
	return position.y + label.position.y + label.size.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _updatePosition():
	if above:
		var newY = above._get_lowest() + margin
		if (position.y != newY):
			position.y = newY
			if below:
				below._updatePosition()
	pass
