extends Node

## Propertie's

var history: Array[Dictionary] = []

const scene := "res://scenes/crash_scene.tscn"

## Main

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Force-Crash-Game"):
		CrashManager.err("Намеренный краш игры.")

## Open crash screen
func _crash_game() -> void: get_tree().change_scene_to_file(scene)

## Util's

func note(icontext: String) -> void:
	var log = "[NOTE] %s" % icontext
	history.append({ "line": log, "color": Color("999999") })
	print(log)

func info(icontext: String) -> void:
	var log = "[INFO] %s" % icontext
	history.append({ "line": log, "color": Color("44ff44") })
	print(log)


func warn(icontext: String) -> void:
	var log = "[WARNING] %s" % icontext
	history.append({ "line": log, "color": Color("ff8800") })
	print(log)

func err(icontext: String) -> void:
	var log = "[ERROR] %s" % icontext
	history.append({ "line": log, "color": Color("ff0000") })
	print(log)
	_crash_game()
