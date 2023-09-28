extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for i in range(1, 18):
        var highest_score = Global.get_score(i)
        if highest_score > -1:
            var level = get_node("Levels/Level%d" % i)
            level.score = highest_score
            level.reveal_stars()

            var next_level = get_node("Levels/Level%d" % (i + 1))
            next_level.unlocked = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
