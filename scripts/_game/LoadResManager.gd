extends Node

## Properties

var nextScene = null
var jokeMode: bool = false

const path := "res://scenes/loading_scene.tscn"

signal loadStarted
signal loadCompleted

## Main

func changeScene(localPath: String, ijokeMode: bool = false) -> void:
	# Enable/Disable joke-mode XD
	jokeMode = ijokeMode
	
	# switch next scene path
	nextScene = "res://scenes/"+localPath+".tscn"
	
	# Change current scene to loading scene
	get_tree().change_scene_to_file(path)
