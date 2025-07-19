extends Node

## Properties

var musics: Dictionary = {
	"main-menu": [
		{ "name": "Choose Joy", "bpm": 75, "id": "choose_joy" },
		{ "name": "Exploration chiptune RPG Adventure", "bpm": 75, "id": "exploration_chiptune_rpg_adventure" },
		{ "name": "Game mode - ON", "bpm": 130, "id": "game_mode_on" }
	]
}

var musicTime: float = 0.0
var musicBpm: float = 0.0
var totalBites: int = 0

signal onMusicPlaying(musicName: String)
signal onVolumeChanged(vol: float)
signal onMusicBite(total: int)

## Main

func _ready() -> void:
	onMusicBite.connect(_onMusicBite)
	onMusicPlaying.connect(_onMusicPlaying)

func _onMusicBite() -> void: totalBites += 1

func _onMusicPlaying(musicName: String) -> void:
	CrashManager.info("Сейчас играет: \"%s\"" % musicName)

## Util's

func addSoundStream(icategory: String, iuniqueId: String, istream: AudioStreamPlayer) -> void:
	if istream:
		Game.sounds[icategory]["streams"][iuniqueId] = istream
		CrashManager.info("Звук '%s' добавлени в категорию: %s" % [iuniqueId, icategory])
	else:
		CrashManager.warn("не удалось добавить звук '%s' в категорию: %s!" % [istream, icategory])

func clearSoundStreams() -> void:
	for category in Game.sounds.keys():
		Game.sounds[category]["streams"] = {}

func stopPlayingCategory(icategory: String) -> void:
	var category = Game.sounds[icategory]["streams"]
	var streams = category.keys()
	for stream in streams: pass

## player random music from music category
## @param mcategory - Music category
## @param scategory - Stream ID category
## @return bpm - Bite per minute
func playRandomSoundCategory(mcategory: String, scategory: String) -> float:
	if !Game.sounds["music"]["streams"][scategory].playing:
		var musicData = musics[mcategory].pick_random()
		var mName = musicData["name"]
		var mBpm = musicData["bpm"]
		var mId = musicData["id"]
		
		var stream = Game.sounds["music"]["streams"][scategory]
		stream.stream = load("res://sounds/music/"+mId+".mp3")
		
		onMusicPlaying.emit(mName)
		musicBpm = mBpm
		stream.play()
	return musicBpm
