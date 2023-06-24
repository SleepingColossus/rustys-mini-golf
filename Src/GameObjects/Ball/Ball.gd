extends RigidBody2D

const MOVEMENT_THRESHOLD = 1.2
const MOVEMENT_FACTOR_GRASS = 2.0
const MOVEMENT_FACTOR_SAND = 1.0

var movement_factor : float

# Called when the node enters the scene tree for the first time.
func _ready():
    movement_factor = MOVEMENT_FACTOR_GRASS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func is_moving():
    return get_linear_velocity().length() > MOVEMENT_THRESHOLD


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
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
                if layer_index == 3:
                    movement_factor = MOVEMENT_FACTOR_SAND
                print_debug("collided with tile in layer %d" % layer_index)


func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
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
                if layer_index == 3:
                    movement_factor = MOVEMENT_FACTOR_GRASS
                print_debug("exited layer %d" % layer_index)
