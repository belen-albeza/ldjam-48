extends KinematicBody2D
class_name Hero

signal speak_finished

export(int, 0, 200) var MAX_SPEED := 100
export(int, 0, 1000) var ACCELERATION := 1000
export(int, 0, 1000) var FRICTION := 500

const TEXT_BALLOON_SCENE := preload("res://ui/TextBalloon.tscn")

# Declare member variables here.
var _velocity := Vector2.ZERO
var is_frozen := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
  if is_frozen:
    _velocity = Vector2.ZERO
    return

  # compute velocity out of player's input
  var input_dir := _get_direction_from_input()
  if input_dir != Vector2.ZERO:
    _velocity = _velocity.move_toward(input_dir * MAX_SPEED, ACCELERATION * delta)
  else:
    _velocity = _velocity.move_toward(Vector2.ZERO, FRICTION * delta)
  # move the character
  move_and_slide(_velocity, Vector2.ZERO)

# Helper to get a normalized direction from the player's input
func _get_direction_from_input() -> Vector2:
    var dir := Vector2(
      Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
      Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
    )

    return dir.normalized()

func speak(phrases: Array) -> void:
  if is_frozen:
    return

  is_frozen = true

  var balloon := TEXT_BALLOON_SCENE.instance() as TextBalloon
  var ui_node = get_node("../UI")
  ui_node.add_child(balloon)
  var balloon_position2D := ($BalloonPosition2D as Position2D)
  # TODO: need to investigate why the anchor of the balloon seems to not being taken into account
  var target_position = balloon_position2D.get_global_transform_with_canvas().origin + Vector2(-4, -16)
  balloon.set_global_position(target_position)
  balloon.phrases = phrases
  balloon.connect("phrases_ended", self, "_on_text_balloon_ended", [balloon])

func _on_text_balloon_ended(balloon: TextBalloon) -> void:
  balloon.queue_free()
  is_frozen = false
  emit_signal("speak_finished")

