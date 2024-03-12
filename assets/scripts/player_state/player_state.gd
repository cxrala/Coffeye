extends Node
class_name PlayerState

var exhaustion : float
var concentration : float

func get_exhaustion():
	return exhaustion
	
func get_concentration():
	return concentration

@export var startExhaustionTimeFactor = 0.025
@export var startConcentrationTimeFactor = 0.025

var exhaustionTimeFactor : float
var concentrationTimeFactor : float

@export var timeScaleFactor = 60.0
var totalTimeInHours = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_restart()
	pass # Replace with function body.

func _restart():
	exhaustion = 0
	concentration = 0
	exhaustionTimeFactor = startExhaustionTimeFactor
	concentrationTimeFactor = startConcentrationTimeFactor

func coffee():
	exhaustion = 0;
	exhaustionTimeFactor *= 1.5
	concentration /= 3;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	exhaustion += delta * exhaustionTimeFactor
	concentration += delta * concentrationTimeFactor
	totalTimeInHours += delta * timeScaleFactor
	
	if exhaustion > 1:	
		get_tree().change_scene_to_file("res://assets/scenes/GameOver.tscn")
	
