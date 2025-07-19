extends Node3D

## Parameter's

@onready var music := $control/music

@onready var bgScroll := $"background-scroll"
@onready var cameraCenter := $"camera-center"
@onready var camera3d := $"camera-center/camera3d"

## Main

func _ready() -> void:
	SoundManager.addSoundStream("music", "music", music)
	
	SoundManager.onMusicBite.connect(_onMusicBite)

func _process(delta: float) -> void:
	SoundManager.playRandomSoundCategory("main-menu", "music")
	bpmCalc(delta)
	
	# Return zoom camera to normal
	camera3d.fov = lerp(camera3d.fov, 70.0, delta)

func _physics_process(delta: float) -> void:
	# Move noise texture
	bgScroll.get_surface_override_material(0).albedo_texture.noise.offset += Vector3(
		delta * 8, delta * 8, 0
	)
	
	# Rotate camera
	cameraCenter.rotation += Vector3(delta / 8, delta / 8, 0)

func bpmCalc(delta: float) -> void:
	if SoundManager.musicBpm <= 0.0: return # Избегаем деления на ноль или некорректного BPM
	
	SoundManager.musicTime += delta # Увеличиваем накопленное время
	
	# Вычисляем интервал между битами (в секундах)
	var beat_interval: float = 60.0 / SoundManager.musicBpm
	
	# Проверяем, прошёл ли интервал для одного бита
	if SoundManager.musicTime >= beat_interval:
		SoundManager.onMusicBite.emit()
		# Вычитаем интервал бита, чтобы сохранить остаток времени
		SoundManager.musicTime -= beat_interval
		# Увеличиваем счётчик битов
		SoundManager.totalBites += 1

func _onMusicBite() -> void:
	# Camera zooming
	camera3d.fov = 65.0
