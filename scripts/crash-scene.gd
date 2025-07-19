extends Control

@onready var console := $"margin/console/console_bg/margin/scroll-area/v"

func _ready() -> void:
	var latest = CrashManager.history
	for lineID in range(latest.size()):
		var label = Label.new()
		label.text = latest[lineID]["line"]
		label.modulate = latest[lineID]["color"]
		console.add_child(label)

func _input(event: InputEvent) -> void:
	var onRestart := Input.is_action_just_pressed("ui_accept")
	var onExit := Input.is_action_just_pressed("ui_cancel")
	
	if onRestart: get_tree().change_scene_to_file("res://scenes/startup_scene.tscn")
	elif onExit: get_tree().quit()
