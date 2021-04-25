extends Control
class_name TextBalloon

signal phrases_ended

var phrases: Array = [""] setget set_phrases
onready var label := ($MarginContainer/VBoxContainer/Label as Label)
onready var continueArrow := ($Continue as Control)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass


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
    var new_size := _get_label_size()

    # resize the balloon
    set_size(new_size)

    # show or hide continue arrow
    if len(phrases) > 0:
      var offset := new_size.x - 5
      continueArrow.rect_position.x = offset
      continueArrow.show()
    else:
      continueArrow.hide()
  else:
    emit_signal("phrases_ended")

func _get_label_size() -> Vector2:
  # ÑAPA: this is done to refresh the label size computation…
  label.hide()
  label.show()

  return label.get_combined_minimum_size()
