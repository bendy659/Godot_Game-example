extends Node

## language supported for game
var support_langs: Array[Dictionary] = [
	{ "name": "Russian (RU)", "id": "ru_ru" }, # ID = 0
	{ "name": "English (US)", "id": "en_us" }  # ID = 1
]

## Current selected language | ID
var current: int = 0

## Loaded translations
var translation: Dictionary = {}

## Language dir path
const dir: String = "res://lang"

## Signal for reload translate
signal onLanguageChanged(id: int)

### ====

## Get lines for json
func loadTranslate(id: int) -> void:
	var lang = support_langs[id]["id"] # Get selected lang ID
	var file = FileAccess.open(dir + "/" + lang + ".json", FileAccess.READ) # Read translation file
	if file: # Else this file not null or exist
		var text = file.get_as_text() # Get lines from file
		file.close() # End reading file
		
		var json = JSON.new() # Create Json-object
		var parsed = json.parse(text) # Try parsing from readed lines
		
		if parsed == OK: # If parsing ended good
			translation = json.data
			CrashManager.info("Парсинг перевода прошёл успешно!")
		else: # else parsing ended failed
			CrashManager.warn("Произошла ошибка при попытке парсинга перевода!\n at %s" % json.get_error_message())
		
		CrashManager.info("Перевод для языка [%s] из файла [%s] был загружен" % [lang, file])
	else: # If this readed file in null or not exist
		CrashManager.warn("Ошибка при чтении файла [%s] для языка [%s]!" % [file, lang])

func translate(key: String, type: Variant) -> String:
	return ""
