extends Control
class_name TextBalloon

signal phrases_ended


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var phrases: Array = [""] setget set_phrases
onready var label := ($MarginContainer/VBoxContainer/Label as Label)
onready var continueArrow := ($Continue as Control)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#  pass

func _input(event: InputEvent) -> void:
  if event.is_action_released("ui_accept"):
    show_next_phrase()


func set_phrases(new_phrases: Array) -> void:
  phrases = new_phrases
  show_next_phrase()


func show_next_phrase() -> void:
  var text = phrases.pop_front()

  if text:
    label.text = "  " + (text as String) + "  "

    # show or hide continue arrow
    if len(phrases) > 0:
      var offset := _get_label_width() - 5
      continueArrow.rect_position.x = offset
      continueArrow.show()
    else:
      continueArrow.hide()
  else:
    emit_signal("phrases_ended")

func _get_label_width() -> float:
  label.hide()
  label.show()
  return label.get_combined_minimum_size().x
