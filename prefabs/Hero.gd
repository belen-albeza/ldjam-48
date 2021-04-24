extends KinematicBody2D
class_name Hero

export(int, 0, 200) var MAX_SPEED := 100
export(int, 0, 1000) var ACCELERATION := 1000
export(int, 0, 1000) var FRICTION := 500


# Declare member variables here.
var _velocity := Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
  # compute velocity out of player's input
  var input_dir = _get_direction_from_input()
  if input_dir != Vector2.ZERO:
    _velocity = _velocity.move_toward(input_dir * MAX_SPEED, ACCELERATION * delta)
  else:
    _velocity = _velocity.move_toward(Vector2.ZERO, FRICTION * delta)
  # move the character
  move_and_slide(_velocity, Vector2.ZERO)

# Helper to get a normalized direction from the player's input
func _get_direction_from_input() -> Vector2:
    var dir: Vector2 = Vector2(
      Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
      Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
    )

    return dir.normalized()
