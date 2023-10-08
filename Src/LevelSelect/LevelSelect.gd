extends Control


const NUMBER_OF_LEVELS = 18


func _ready() -> void:
    for i in range(1, NUMBER_OF_LEVELS + 1):
        var highest_score = Global.get_score(i)

        # do something if the level has a score
        if highest_score > -1:
            # set the number of stars on island
            var level = get_node("Levels/Level%d" % i)
            level.score = highest_score
            level.reveal_stars()

            # unlock next level
            # unless level number is out of bounds
            if i < NUMBER_OF_LEVELS:
                var next_level = get_node("Levels/Level%d" % (i + 1))
                next_level.unlocked = true

    _set_total_score_label()


func _on_back_button_pressed() -> void:
    SoundPlayer.play_sound($ClickSound)
    get_tree().change_scene_to_file("res://MainMenu/MainMenu.tscn")


func _set_total_score_label() -> void:
    var total_score = Global.aggregate_score()
    var max_stars = 3 * 18

    $TotalContainer/TotalScore.text = "%d/%d" % [total_score, max_stars]
