extends Node


func _ready() -> void:
    if Options.play_music:
        $Music.play()
