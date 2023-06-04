extends RigidBody2D

const MOVEMENT_THRESHOLD = 1.2

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func is_moving():
    return get_linear_velocity().length() > MOVEMENT_THRESHOLD
