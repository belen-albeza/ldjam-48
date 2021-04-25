extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  VisualServer.set_default_clear_color(Color.black)
  ($Hero as Hero).speak(["Was I a good elf?", "Maybe not…"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#  pass
