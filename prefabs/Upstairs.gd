extends Area2D
class_name Upstairs

signal hero_entered(upstairs)


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#  pass


func _on_body_entered(_body: Node) -> void:
  emit_signal("hero_entered", self)
