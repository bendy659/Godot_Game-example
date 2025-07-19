extends Node

## ====

## === [ Game settings ] ===

## General

var cLangID = 0 # Selected language ID

## Control

var mouseSenc: float = 1.0 # Mouse senc

## Sounds

var sounds: Dictionary = {
	"general": { "volume": 1.0, "streams": null },
	"music": { "volume": 1.0, "streams": {} },
	"env": { "volume": 1.0, "streams": {} },
	"ui": { "volume": 1.0, "streams": {} },
	"sfx": { "volume": 1.0, "streams": {} },
	"dialogues": { "volume": 1.0, "streams": {} }
}

## Graphics

# Nothing

## ====

## Main

## Init game
func _ready() -> void:
	Language.loadTranslate(cLangID)

## ====

## Util's

func wait(time: float) -> void:
	await get_tree().create_timer(time).timeout
