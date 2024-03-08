extends Button

@export var sprite : Sprite2D
@export var upTexture : Texture2D
@export var downTexture : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = upTexture
	button_down.connect(self._on_button_down)
	button_up.connect(self._on_button_up)

func _on_button_down():
	sprite.texture = downTexture
	pass

func _on_button_up():
	sprite.texture = upTexture
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
