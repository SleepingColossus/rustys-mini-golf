extends Control


func _on_play_pressed() -> void:
    $ClickSound.play()
    get_tree().change_scene_to_file("res://LevelSelect/LevelSelect.tscn")


func _bool_to_string(option_state: bool) -> String:
    var str = "ON" if option_state else "OFF"
    return str


func _on_tutorial_pressed() -> void:
    Options.play_tutorials = !Options.play_tutorials

    var label = "TUTORIAL: %s" % (_bool_to_string(Options.play_tutorials))
    $Navigation/ToggleTutorial.text = label


func _on_sound_on_pressed() -> void:
    Options.play_sounds = !Options.play_sounds

    var label = "SOUND: %s" % (_bool_to_string(Options.play_sounds))
    $Navigation/ToggleSound.text = label


func _on_music_on_pressed() -> void:
    Options.play_music = !Options.play_music

    var label = "MUSIC: %s" % (_bool_to_string(Options.play_music))
    $Navigation/ToggleMusic.text = label
