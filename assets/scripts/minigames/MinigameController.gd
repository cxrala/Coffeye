extends Node2D
class_name MinigameController

@export var target = 10
@export var progress = 0
signal finished_task_event

# Called when the node enters the scene tree for the first time.
func _ready():
	target = 10
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_game():
	pass
