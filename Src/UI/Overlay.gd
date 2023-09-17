extends CanvasLayer

signal tutorial_complete

@export var level_camera : Camera2D
@export var ball : Ball

var _message_index := 0
@export var text_lines : Array[String]

func _ready() -> void:
    %TutorialAnimator.play("show")
    %Text.text = text_lines[_message_index]
    %ScrollingTextAnimator.play("scroll_text")

func _toggle_zoom():
    print_debug("Camera toggled")
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
    _toggle_zoom()


func _on_next_button_pressed() -> void:
    _next_message()


func update_shot_tracker(shots_taken: int) -> void:
    $Overlay/ShotTracker.text = "Shots: %d" % shots_taken


func show_scoreboard(shots_taken: int, gold_score: int, silver_score: int) -> void:
    $Overlay/Scoreboard/ScoreboardAnimator.play("show")
    $Overlay/Scoreboard/Stats/VBoxContainer/Moves.text = "Moves: %d" % shots_taken

    if shots_taken <= gold_score:
        $Overlay/Scoreboard/Stats/VBoxContainer/NextStar.visible = false
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star1.visible = true
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star2.visible = true
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star3.visible = true
    if shots_taken <= silver_score:
        $Overlay/Scoreboard/Stats/VBoxContainer/NextStar.text = "Next Star: %d" % gold_score
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star1.visible = true
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star2.visible = true
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star3.visible = false
    else:
        $Overlay/Scoreboard/Stats/VBoxContainer/NextStar.text = "Next Star: %d" % silver_score
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star1.visible = true
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star2.visible = false
        $Overlay/Scoreboard/Stats/VBoxContainer/Stars/Star3.visible = false
