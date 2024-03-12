extends GameWindow

@export var albums : Array[AlbumTuple]
@export var audio : AudioStreamPlayer2D
@export var albumCoverSprite : Sprite2D
@export var albumNameLabel : Label
@export var audioBar : ColorRect

@export var trackSection : Node2D
@export var trackPrefab : PackedScene

@export var startStopButton : StartStopButton
@export var rewindButton : TextureButton
@export var skipButton : TextureButton

@export var trackName : Label
@export var trackComposer : Label

@export var trackTime : Label
@export var trackEnd : Label

const trackHeight = 8

var trackDisplays : Array[Track]

var currentAlbum : int
var currentTrack : int

var currentTrackTuple : TrackTuple

var playing = true

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	currentAlbum = 0
	currentTrack = 0
	_create_track_section()
	audio.finished.connect(_next_track)
	_play_track(0)
	startStopButton.pressed.connect(_start_stop)
	rewindButton.pressed.connect(_rewind_track)
	skipButton.pressed.connect(_next_track)
	pass # Replace with function body.

func _clear_track_section():
	for track in trackDisplays:
		trackSection.remove_child(track)
	trackDisplays.clear()

func _current_album():
	return albums[currentAlbum]

func _next_track():
	audio.stop()
	currentTrack += 1
	currentTrack %= _current_album().tracks.size()
	_setup_new_track()
	if playing:
		audio.play()
	else:
		audio.seek(0)

func _setup_new_track():
	var newTrack = _current_album().tracks[currentTrack]
	currentTrackTuple = newTrack
	audio.stream = newTrack.track
	trackName.text = newTrack.title
	trackComposer.text = newTrack.composer

func _rewind_track():
	if (audio.get_playback_position() > 1):
		if (audio.playing):
			audio.play(0)
		else:
			audio.seek(0)
	else:
		_prev_track()

func _prev_track():
	audio.stop()
	currentTrack -= 1
	if (currentTrack < 0):
		currentTrack = _current_album().tracks.size() - 1
	_setup_new_track()
	if playing:
		audio.play()
	else:
		audio.seek(0)

func _create_track_section():
	var tracks = _current_album().tracks
	for i in range(tracks.size()):
		var track : Track
		track = trackPrefab.instantiate()
		track.set_track(tracks[i])
		track.trackButton.pressed.connect(func() : _play_track(i))
		track.position.y = i * trackHeight
		
		trackDisplays.append(track)
		trackSection.add_child(track)

func _play_track(index : int):
	_start_playing()
	currentTrack = index
	_setup_new_track()
	audio.play()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	audioBar.size.x = audio.get_playback_position() * 88 / albums[currentAlbum].tracks[currentTrack].track.get_length()
	if trackTime:
		trackTime.text = _to_display_time(audio.get_playback_position())
	if trackEnd:
		trackEnd.text = _to_display_time(currentTrackTuple.track.get_length() - audio.get_playback_position())

func _start_playing():
	playing = true
	startStopButton.play()

func _start_stop():
	playing = !playing
	if playing:
		if !audio.playing:
			audio.play(audio.get_playback_position())
		startStopButton.play()
		audio.stream_paused = false
	else:
		startStopButton.pause()
		audio.stream_paused = true

func _to_display_time(seconds : float):
	var mins : int
	mins = seconds / 60
	var secs : int
	secs = seconds - mins * 60
	if secs < 10:
		return "%d:0%d" % [mins, secs]
	else:
		return "%d:%d" % [mins, secs]
