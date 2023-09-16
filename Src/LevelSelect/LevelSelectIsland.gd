extends Sprite2D

@export var score : int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    reveal_start()


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
