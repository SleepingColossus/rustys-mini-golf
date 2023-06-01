extends Node2D

var _mouse_position = null
var _is_mouse_down := false
@onready var _ball = $Ball

func _ready():
    pass


func _process(delta):
    pass


func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT:
            if event.is_pressed():
                _is_mouse_down = true
            else:
                _is_mouse_down = false

    if event is InputEventMouseMotion and _is_mouse_down:
        _mouse_position = get_local_mouse_position()
    else:
        _mouse_position = null

    queue_redraw()


func _draw():
    if _mouse_position != null:
        draw_line(_ball.position, _mouse_position, Color.YELLOW, 6)
