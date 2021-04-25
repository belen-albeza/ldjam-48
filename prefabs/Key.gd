extends Area2D
class_name Key

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.



func _on_body_entered(hero: Hero) -> void:
  hero.pick_up(Hero.Item.KEY)
  queue_free()
