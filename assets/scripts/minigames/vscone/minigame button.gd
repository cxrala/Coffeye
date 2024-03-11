extends TextureButton
@export var glowtexture : Texture2D
@export var standardtexture: Texture2D
@export var controller : Node2D
@export var timer : Timer
@export var buttonindex : int
var shiny = false 
var glow = 0
# Called when the node enters the scene tree for the first time.$"../Haskell Button"
func _ready():
	controller.on.connect(setglow)
	timer.timeout.connect(makeglow)
	controller.value.connect(sequentialglow)
	pass # Replace with function body.
func sequentialglow(number):
	pass

func setglow():
	glow = 1
	self.texture_normal = standardtexture
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func makeglow(): 
	if glow == 0 :
		shiny = !shiny
		if shiny == true :
			self.texture_normal = glowtexture
		if shiny == false :
			self.texture_normal = standardtexture 
