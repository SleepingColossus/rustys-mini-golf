class_name Ball

extends RigidBody2D


signal hole_entered


const LAYER_TERRAIN = 0
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

# sounds
@onready var hit_sound := $Sounds/HitSound
@onready var bounce_sound := $Sounds/BounceSound
@onready var splash_sound := $Sounds/SplashSound
@onready var enter_hole_sound := $Sounds/EnterHoleSound

# particles
@onready var hit_particles := $Particles/HitParticles

func _ready():
    movement_factor = MOVEMENT_FACTOR_GRASS
    _last_known_position = position
    visible = true


func can_move():
    var is_stationary = get_linear_velocity().length() < MOVEMENT_THRESHOLD
    return is_stationary and !_is_dead and !_has_won


func move(forceX, forceY):
    _last_known_position = position
    hit_particles.emitting = true
    SoundPlayer.play_sound(hit_sound)
    apply_impulse(Vector2(forceX, forceY))


func stop():
    linear_velocity = Vector2.ZERO
    _is_dead = true


func reset_position():
    position = _last_known_position
    _is_dead = false


func _win():
    SoundPlayer.play_sound(enter_hole_sound)
    $DelayVictoryTimer.start()
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
                if layer_index == LAYER_TERRAIN:
                    SoundPlayer.play_sound(bounce_sound)
                elif layer_index == LAYER_HOLE:
                    _win()
                elif layer_index == LAYER_WATER:
                    $DrownAnimation.play("die_and_reset")
                elif layer_index == LAYER_SAND:
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


func _on_body_entered(_body: Node) -> void:
    hit_particles.emitting = true


func _play_splash_sound() -> void:
    SoundPlayer.play_sound(splash_sound)


func _on_delay_victory_timer_timeout() -> void:
    hole_entered.emit()
