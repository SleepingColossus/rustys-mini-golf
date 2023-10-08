extends Node2D

enum State {
    INTRO_STATE,
    GAMEPLAY_STATE
}


@export var three_star_condition : int
@export var two_star_condition : int
@export var level_number : int

var _state : State
var _mouse_position = null
var _is_mouse_down := false
var _shots_taken := 0
@onready var _ball = $Ball


func _ready():
    if Options.play_tutorials:
        _state = State.INTRO_STATE
        $Overlay.tutorial_complete.connect(_on_tutorial_complete)
    else:
        _state = State.GAMEPLAY_STATE

    $Overlay.update_shot_tracker(_shots_taken)
    _ball.hole_entered.connect(_on_hole_entered)


func _process(_delta):
    if Input.is_action_just_pressed("toggle_zoom"):
        _toggle_zoom()


func _input(event):
    if _state == State.GAMEPLAY_STATE:
        if event is InputEventMouseButton:
            if event.button_index == MOUSE_BUTTON_LEFT:
                if event.is_pressed():
                    _is_mouse_down = true
                else:
                    _is_mouse_down = false
                    _mouse_released()

        if event is InputEventMouseMotion and _is_mouse_down:
            _mouse_position = get_local_mouse_position()
        else:
            _mouse_position = null

        queue_redraw()


func _draw():
    if _state == State.GAMEPLAY_STATE:
        if _mouse_position != null and _ball.can_move():
            var end_point = _mouse_position
            var distance = _ball.position.distance_to(end_point)

            if distance > 100:
                var direction = (end_point - _ball.position).normalized()
                end_point = _ball.position + direction * 100

            var color : Color

            if distance < 25:
                color = Color.YELLOW
            elif distance < 50:
                color = Color.CORAL
            elif distance < 75:
                color = Color.ORANGE
            else:
                color = Color.RED

            draw_line(_ball.position, end_point, color, 6)


func _mouse_released():
    print_debug("Ball's linear velocity: %s" % _ball.get_linear_velocity().length())
    if _mouse_position != null and _ball.can_move():
        var end_point = _mouse_position
        var distance = _ball.position.distance_to(end_point)

        if distance > 100:
            var direction = (end_point - _ball.position).normalized()
            end_point = _ball.position + direction * 100

        var forceX = (end_point.x - _ball.position.x) * _ball.movement_factor
        var forceY = (end_point.y - _ball.position.y) * _ball.movement_factor

        _shots_taken += 1
        $Overlay.update_shot_tracker(_shots_taken)
        _ball.move(forceX, forceY)


func _toggle_zoom():
    print_debug("Camera toggled")
    $LevelCamera.enabled = not $LevelCamera.enabled
    $Ball/BallCamera.enabled = not $Ball/BallCamera.enabled


func _on_tutorial_complete():
    _state = State.GAMEPLAY_STATE


func _on_hole_entered():
    var stars_earned : int

    if _shots_taken <= three_star_condition:
        stars_earned = 3
    elif _shots_taken <= two_star_condition:
        stars_earned = 2
    else:
        stars_earned = 1

    Global.set_score(level_number, stars_earned)
    $Overlay.show_scoreboard(stars_earned, _shots_taken, three_star_condition, two_star_condition)
