extends CanvasLayer

@export var level_camera : Camera2D
@export var ball : Ball

func _toggle_zoom():
    print_debug("Camera toggled")
    level_camera.enabled = not level_camera.enabled
    ball.ball_camera.enabled = not ball.ball_camera.enabled


func _on_zoom_button_pressed() -> void:
    _toggle_zoom()
