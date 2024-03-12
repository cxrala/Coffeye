extends TextureButton
class_name StartStopButton

@export var playTexture : Texture2D
@export var pauseTexture : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play():
	texture_normal = pauseTexture
	texture_pressed = pauseTexture

func pause():
	texture_normal = playTexture
	texture_pressed = playTexture
