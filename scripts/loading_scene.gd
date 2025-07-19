extends Control

var loadResManager := LoadResManager
var resLoader := ResourceLoader

@onready var progressBar := $"margin/progress-bar/background/fill"
@onready var progressLabel := $"margin/progress-bar/load-statistic"

@onready var pressLabel := $"margin/Control/press-space"
@onready var progressBarControl := $"margin/progress-bar"

var barSizeX: float = 0
var animTime: float = 0.0
var waitContinue: bool = false

var packed = null

signal onSpacePressed

## Main

func _ready() -> void:
	barSizeX = progressBar.size.x
	
	loadResManager.loadStarted.connect(_onLoadStarted)
	loadResManager.loadCompleted.connect(_onLoadCompleted)
	
	# Start loading
	loadResManager.loadStarted.emit()
	resLoader.load_threaded_request(loadResManager.nextScene)
	
	# Waiting load next scene
	await loadResManager.loadCompleted
	await onSpacePressed
	set_process(false)
	
	if packed: get_tree().change_scene_to_packed(packed)
	else: CrashManager.err("Не удалось загрузить сцену [%s]" % loadResManager.nextScene)

func _process(delta: float) -> void:
	if !waitContinue:
		var progresses = []
		
		# Get progress
		resLoader.load_threaded_get_status(loadResManager.nextScene, progresses)
		
		# Set grogress value on bar
		progressBar.size.x = barSizeX * progresses[0]
		progressLabel.text = str(progresses[0] * 100) + "%"
		
		# If loading is complete (full loaded)
		if progresses[0] == 1:
			loadResManager.loadCompleted.emit()
			packed = resLoader.load_threaded_get(loadResManager.nextScene)
			waitContinue = true
	else:
		animTime += delta
		
		pressLabel.modulate = Color("ffffff", sin(animTime * PI) + 1)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") && waitContinue:
		onSpacePressed.emit()

## Signal's func's

func _onLoadStarted() -> void:
	pressLabel.visible = false
	progressBarControl.visible = true

func _onLoadCompleted() -> void:
	pressLabel.visible = true
	progressBarControl.visible = false
