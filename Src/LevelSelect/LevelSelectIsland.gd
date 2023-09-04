extends AnimatedSprite2D

var this : AnimatedSprite2D = self

@export var score : int
@export var unlocked : bool
@export var level_name : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    unlock()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func unlock() -> void:
    if score > 0:
        $VictoryAnimation.play("win")

        if score >= 1:
            $Star1.visible = true
            $Star1/StarAnimation.play("enable")
        if score >= 2:
            $Star2.visible = true
            $Star2/StarAnimation.play("enable")
        if score >= 3:
            $Star3.visible = true
            $Star3/StarAnimation.play("enable")


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
    if event is InputEventMouseButton:
        if unlocked:
            get_tree().change_scene_to_file("res://Maps/%s.tscn" % level_name)
