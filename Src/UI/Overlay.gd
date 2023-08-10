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
