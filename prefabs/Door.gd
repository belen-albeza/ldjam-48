extends StaticBody2D
class_name Door


func _on_Area2D_body_entered(hero: PhysicsBody2D) -> void:
  hero.emit_signal("door_collided", self)
