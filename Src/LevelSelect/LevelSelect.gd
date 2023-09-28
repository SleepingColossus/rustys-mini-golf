extends Control


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

    _set_total_score_label()


func _on_back_button_pressed() -> void:
    get_tree().change_scene_to_file("res://MainMenu/MainMenu.tscn")


func _set_total_score_label() -> void:
    var total_score = Global.aggregate_score()
    var max_stars = 3 * 18

    $TotalContainer/TotalScore.text = "%d/%d" % [total_score, max_stars]
