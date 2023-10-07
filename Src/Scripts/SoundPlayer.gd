extends Node


func play_sound(sound) -> void:
    if Options.play_sounds:
        sound.play()
