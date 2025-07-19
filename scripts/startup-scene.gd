extends Control

@onready var video_player: VideoStreamPlayer = $margin/video

func _ready() -> void:
	video_player.play()
	await video_player.finished
	await Game.wait(1)
	
	LoadResManager.changeScene("main_menu")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Restart-Scene"):
		get_tree().reload_current_scene()
