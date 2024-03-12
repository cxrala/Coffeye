extends Node2D
class_name Track


@export var trackButton : TextureButton
@export var trackName : Label
@export var trackComposer : Label
@export var trackLength : Label

var track : TrackTuple

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_track(newTrack : TrackTuple):
	track = newTrack
	trackName.text = track.title
	trackComposer.text = track.composer
	trackLength.text = _to_display_time(track.track.get_length())

func _to_display_time(seconds : float):
	var mins : int
	mins = seconds / 60
	var secs : int
	secs = seconds - mins * 60
	if secs < 10:
		return "%d:0%d" % [mins, secs]
	else:
		return "%d:%d" % [mins, secs]
