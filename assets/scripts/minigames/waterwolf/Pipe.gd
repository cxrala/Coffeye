extends Node2D
class_name Pipe

@export var virtual_position : Vector2
@export var gap_size : Vector2
@export var scored = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_spacing(gap_size : Vector2):
	self.gap_size = gap_size
	$LowerPipe.position.y = gap_size.y
	$UpperPipe.position.y = -256 - gap_size.y
	pass

func setPipeLabels(lower : String, upper : String):
	$LowerPipe/LowerLabel.text = lower
	$UpperPipe/UpperLabel.text = upper

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = round(virtual_position)
	pass
