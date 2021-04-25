extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  ($Dummy as Dummy).speak(["Why…?"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#  pass


func _on_Dummy_speak_finished() -> void:
  get_tree().change_scene("res://ui/TitleScene.tscn")
