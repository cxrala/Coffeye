extends TextureButton

@export var glowtexture : Texture2D
@export var standardtexture: Texture2D
@export var controller : Node2D
@export var timer : Timer
@export var buttonindex : int
@export var sequencetimer : Timer
@export var flashingtimer : Timer

var shiny = false 
var glow = 0
signal starttimer
# Called when the node enters the scene tree for the first time.$"../Haskell Button"
func _ready():
	controller.on.connect(setglow)
	timer.timeout.connect(makeglow)
	controller.value.connect(sequentialglow)
	pass # Replace with function body.
	
func sequentialglow(number):
	if buttonindex == number :
		emit_signal("starttimer")
		flashingtimer.timeout.connect(texturecontrol)
		
func texturecontrol():
	self.texture_normal = glowtexture
	emit_signal("starttimer")
	flashingtimer.timeout.connect(reverttexture)
	
func reverttexture():
	self.texture_normal = standardtexture
	
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
