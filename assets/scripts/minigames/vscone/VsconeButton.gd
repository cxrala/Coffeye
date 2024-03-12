extends TextureButton
class_name VsconeButton

@export var glowtexture : Texture2D
@export var standardtexture: Texture2D
@export var pressedtexture : Texture2D
@export var controller : Node2D
@export var timer : Timer
@export var buttonindex : int 
@export var flashingtimer : Timer

var shiny = false 
var glow = 0
var seqFlash = false

var enabled = true;

var test = 0
# Called when the node enters the scene tree for the first time.$"../Haskell Button"
func _ready():
	setbasetextures()
	controller.on.connect(setglow)
	timer.timeout.connect(makeglow)
	controller.value.connect(sequentialglow)
	flashingtimer.timeout.connect(texturecontrol)
	
func set_enabled(val : bool):
	enabled = val
	setbasetextures()
	
func setbasetextures():
	if enabled:
		self.texture_normal = standardtexture
		self.texture_pressed = pressedtexture
	else:
		self.texture_normal = pressedtexture
		self.texture_pressed = pressedtexture
		
func setglowtextures():
	if enabled:
		self.texture_normal = glowtexture
		self.texture_pressed = glowtexture
	else:
		self.texture_normal = glowtexture
		self.texture_pressed = glowtexture
	
func sequentialglow(number):
	if buttonindex == number :
		seqFlash = true
		texturecontrol()
		
func texturecontrol():
	if seqFlash:
		flashingtimer.stop()
		setglowtextures()
		flashingtimer.timeout.disconnect(texturecontrol)
		flashingtimer.timeout.connect(reverttexture)
		flashingtimer.start(0.25)
	
func reverttexture():
	if seqFlash:
		seqFlash = false
		flashingtimer.stop()
		flashingtimer.timeout.disconnect(reverttexture)
		flashingtimer.timeout.connect(texturecontrol)
		setbasetextures()
	
func setglow():
	glow = 1
	
func startglow():
	glow = 0

func _process(delta):
	pass
	
func makeglow(): 
	if glow == 0 :
		shiny = !shiny
		if shiny == true :
			self.texture_normal = glowtexture
		if shiny == false :
			self.texture_normal = standardtexture 
