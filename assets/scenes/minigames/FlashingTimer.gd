extends Timer
@export var iteration : TextureButton
@export var selection : TextureButton
@export var assignment : TextureButton
@export var haskell : TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	iteration.starttimer.connect(reset) 
	selection.starttimer.connect(reset)
	assignment.starttimer.connect(reset)
	haskell.starttimer.connect(reset)# Replace with function body.

func reset():
	self.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
