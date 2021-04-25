extends Node2D
class_name Level

signal upstairs_entered
signal downstairs_entered(downstairs)

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#  pass

func get_starting_position() -> Vector2:
  return ($StartingPosition2D as Node2D).global_position


func _on_Upstairs_hero_entered(_upstairs: Upstairs) -> void:
  emit_signal("upstairs_entered")


func _on_Downstairs_hero_entered(downstairs: Downstairs) -> void:
  emit_signal("downstairs_entered", downstairs)
