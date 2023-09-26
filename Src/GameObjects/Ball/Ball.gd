class_name Ball

extends RigidBody2D


signal hole_entered


const LAYER_HOLE = 1
const LAYER_WATER = 2
const LAYER_SAND = 3

const MOVEMENT_THRESHOLD = 1.2
const MOVEMENT_FACTOR_GRASS = 2.0
const MOVEMENT_FACTOR_SAND = 1.0

var movement_factor : float
var _last_known_position : Vector2
var _is_dead := false
var _has_won := false

@onready var ball_camera : Camera2D = $BallCamera

func _ready():
    movement_factor = MOVEMENT_FACTOR_GRASS
    _last_known_position = position


func can_move():
    var is_stationary = get_linear_velocity().length() < MOVEMENT_THRESHOLD
    return is_stationary and !_is_dead and !_has_won


func move(forceX, forceY):
    _last_known_position = position
    apply_impulse(Vector2(forceX, forceY))


func stop():
    linear_velocity = Vector2.ZERO
    _is_dead = true


func reset_position():
    position = _last_known_position
    _is_dead = false


func _win():
    hole_entered.emit()
    _has_won = true
    visible = false
    linear_velocity = Vector2.ZERO

func _on_body_shape_entered(body_rid, body, _body_shape_index, _local_shape_index):
    if body is TileMap:
        var tile_coordinatess = body.get_coords_for_body_rid(body_rid)

        for layer_index in body.get_layers_count():
            # do not check for collisions on background layer
            if layer_index < LAYER_HOLE or layer_index > LAYER_SAND:
                continue

            var tile_data = body.get_cell_tile_data(layer_index, tile_coordinatess)

            if not (tile_data is TileData):
                continue
            else:
                if layer_index == LAYER_HOLE:
                    _win()
                if layer_index == LAYER_WATER:
                    $AnimationPlayer.play("die_and_reset")
                if layer_index == LAYER_SAND:
                    movement_factor = MOVEMENT_FACTOR_SAND
                print_debug("collided with tile in layer %d" % layer_index)


func _on_body_shape_exited(body_rid, body, _body_shape_index, _local_shape_index):
    if body is TileMap:
        var tile_coordinatess = body.get_coords_for_body_rid(body_rid)

        for layer_index in body.get_layers_count():
            # do not check for collisions on background layer
            if layer_index != 2 and layer_index != 3:
                continue

            var tile_data = body.get_cell_tile_data(layer_index, tile_coordinatess)

            if not (tile_data is TileData):
                continue
            else:
                if layer_index == LAYER_SAND:
                    movement_factor = MOVEMENT_FACTOR_GRASS
                print_debug("exited layer %d" % layer_index)
