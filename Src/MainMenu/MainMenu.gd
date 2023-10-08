extends Control


@onready var click_sound := $ClickSound

@onready var toggle_tutorial_button := $Navigation/ToggleTutorial
@onready var toggle_sound_button := $Navigation/ToggleSound
@onready var toggle_music_button := $Navigation/ToggleMusic

var _playback_position : float


func _ready() -> void:
    _set_label(toggle_tutorial_button, "TUTORIAL", Options.play_tutorials)
    _set_label(toggle_sound_button, "SOUND", Options.play_sounds)
    _set_label(toggle_music_button, "MUSIC", Options.play_music)


func _on_play_pressed() -> void:
    SoundPlayer.play_sound($ClickSound)
    get_tree().change_scene_to_file("res://LevelSelect/LevelSelect.tscn")


func _bool_to_string(option_state: bool) -> String:
    return "ON" if option_state else "OFF"


func _set_label(button: Button, base_text: String, toggle: bool) -> void:
    var label = "%s: %s" % [base_text, (_bool_to_string(toggle))]
    button.text = label


func _on_tutorial_pressed() -> void:
    SoundPlayer.play_sound($ClickSound)
    Options.play_tutorials = !Options.play_tutorials
    var label = "TUTORIAL: %s" % (_bool_to_string(Options.play_tutorials))
    toggle_tutorial_button.text = label


func _on_sound_on_pressed() -> void:
    SoundPlayer.play_sound($ClickSound)
    Options.play_sounds = !Options.play_sounds
    var label = "SOUND: %s" % (_bool_to_string(Options.play_sounds))
    toggle_sound_button.text = label


func _on_music_on_pressed() -> void:
    SoundPlayer.play_sound($ClickSound)
    Options.play_music = !Options.play_music
    var label = "MUSIC: %s" % (_bool_to_string(Options.play_music))
    toggle_music_button.text = label

    var music := $MenuMusicPlayer/Music

    if !Options.play_music:
        _playback_position = music.get_playback_position()
        music.stop()
    else:
        music.play(_playback_position)
