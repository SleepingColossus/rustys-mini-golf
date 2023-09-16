extends Sprite2D

@export var score : int
@export var unlocked : bool
@export var level_name : String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

    if !unlocked:
        modulate = Color(0.2, 0.2, 0.2)

    reveal_start()

    var rand = RandomNumberGenerator.new()
    var wait_time = rand.randf_range(0.100, 0.500)
    var timer = $FloatAnimation/StartAnimationTimer
    timer.wait_time = wait_time
    timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func reveal_start() -> void:
    if score == 0:
        $Star1.visible = false
        $Star2.visible = false
        $Star3.visible = false
    if score == 1:
        $Star1.visible = true
        $Star2.visible = false
        $Star3.visible = false
    if score == 2:
        $Star1.visible = true
        $Star2.visible = true
        $Star3.visible = false
    if score == 3:
        $Star1.visible = true
        $Star2.visible = true
        $Star3.visible = true


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
    if event is InputEventMouseButton:
        if unlocked:
            get_tree().change_scene_to_file("res://Maps/%s.tscn" % level_name)



func _on_start_animation_timer_timeout() -> void:
    $FloatAnimation.play("float")
