extends CanvasLayer

signal tutorial_complete


@export var level_camera : Camera2D
@export var ball : Ball

var _message_index := 0
@export var text_lines : Array[String]

@onready var click_sound := $Sounds/ClickSound


func _ready() -> void:
    if Options.play_tutorials:
        %TutorialAnimator.play("show")
        %Text.text = text_lines[_message_index]
        %ScrollingTextAnimator.play("scroll_text")


func _toggle_zoom():
    SoundPlayer.play_sound(click_sound)
    level_camera.enabled = not level_camera.enabled
    ball.ball_camera.enabled = not ball.ball_camera.enabled


func _next_message() -> void:
    _message_index += 1

    if _message_index >= text_lines.size():
        tutorial_complete.emit()
        %TutorialAnimator.play("hide")
    else:
        %Text.text = text_lines[_message_index]
        %ScrollingTextAnimator.play("scroll_text")


func _on_zoom_button_pressed() -> void:
    SoundPlayer.play_sound(click_sound)
    _toggle_zoom()


func _on_back_button_pressed() -> void:
    SoundPlayer.play_sound(click_sound)
    get_tree().change_scene_to_file("res://LevelSelect/LevelSelect.tscn")


func _on_next_button_pressed() -> void:
    SoundPlayer.play_sound(click_sound)
    _next_message()


func update_shot_tracker(shots_taken: int) -> void:
    $Overlay/ShotTracker.text = "Shots: %d" % shots_taken


func show_scoreboard(stars_earned: int, shots_taken: int, three_star_score: int, two_star_condition: int) -> void:
    $Overlay/Scoreboard/ScoreboardAnimator.play("show")
    $Overlay/Scoreboard/Stats/VBoxContainer/Moves.text = "Moves: %d" % shots_taken

    if stars_earned == 3:
        $Overlay/Scoreboard/Stats/VBoxContainer/NextStar.visible = false
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star1.visible = true
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star2.visible = true
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star3.visible = true
        SoundPlayer.play_sound($Sounds/Win3StarSound)
    elif stars_earned == 2:
        $Overlay/Scoreboard/Stats/VBoxContainer/NextStar.text = "Next Star: %d" % three_star_score
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star1.visible = true
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star2.visible = true
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star3.visible = false
        SoundPlayer.play_sound($Sounds/Win2StarSound)
    else:
        $Overlay/Scoreboard/Stats/VBoxContainer/NextStar.text = "Next Star: %d" % two_star_condition
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star1.visible = true
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star2.visible = false
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star3.visible = false
        SoundPlayer.play_sound($Sounds/Win1StarSound)


func _on_menu_button_pressed() -> void:
    SoundPlayer.play_sound(click_sound)
    get_tree().change_scene_to_file("res://MainMenu/MainMenu.tscn")


func _on_replay_button_pressed() -> void:
    SoundPlayer.play_sound(click_sound)
    get_tree().reload_current_scene()


func _on_next_level_button_pressed() -> void:
    SoundPlayer.play_sound(click_sound)
    get_tree().change_scene_to_file("res://LevelSelect/LevelSelect.tscn")

