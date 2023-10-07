extends Node


var scores := {
    1: -1,
    2: -1,
    3: -1,
    4: -1,
    5: -1,
    6: -1,
    7: -1,
    8: -1,
    9: -1,
    10: -1,
    11: -1,
    12: -1,
    13: -1,
    14: -1,
    15: -1,
    16: -1,
    17: -1,
    18: -1,
}


func get_score(level_number: int) -> int:
    assert(level_number >= 1 and level_number <= 18, \
           "ERROR: %d is an invalid level number! Must be between 1-18" % level_number)
    return scores[level_number]


func set_score(level_number: int, new_score: int) -> void:
    assert(level_number >= 1 and level_number <= 18, \
           "ERROR: %d is an invalid level number! Must be between 1-18" % level_number)

    var previous_score: int = scores[level_number]

    if new_score > previous_score:
        scores[level_number] = new_score


func aggregate_score() -> int:
    var total_stars = 0

    for level_number in scores:
        var score = scores[level_number]
        if score > -1:
            total_stars += score

    return total_stars
