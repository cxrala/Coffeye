extends Sprite2D
class_name Mouse

@export var gravity = 160
@export var upVelocity = 80

@export var mouseOffset = Vector2 (8, 11)

@export var mouseRadius = 3

@export var mouseFlap : Texture2D
@export var mouseFall : Texture2D

@export var flashTime = 0.03

var flashTimer = 0;
@export var flashing = false

var velocity = Vector2 (0, 0)
var centre = Vector2 (0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = mouseFall
	pass # Replace with function body.

func flap():
	velocity = -upVelocity * Vector2.DOWN
	texture = mouseFlap

func get_centre():
	return centre

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	centre = position + offset
	velocity += delta * gravity * Vector2.DOWN
	position += delta * (velocity + 0.5 *  delta * gravity * Vector2.DOWN)
	if (velocity.y > 0):
		texture = mouseFall
	if (flashing):
		if (flashTimer > 0) :
			flashTimer -= delta
		else:
			flashTimer = flashTime
			visible = !visible
	elif (!visible):
		visible = true
		
