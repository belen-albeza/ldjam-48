extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var dummy := $Dummy as Dummy
onready var animation := $AnimationPlayer as AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  dummy.connect("speak_finished", self, "move_dummy_to_center", [], CONNECT_ONESHOT)
  dummy.speak(["Press enter…", "That's how you", "advance dialogues."])


func move_dummy_to_center():
  animation.play("move_dummy_to_center", -1, 2)

func teach_movement():
  dummy.connect("speak_finished", self, "move_dummy_to_half_exit", [], CONNECT_ONESHOT)
  dummy.speak(["While in the adventure", "you can move me", "with arrow keys."])

func move_dummy_to_half_exit():
  animation.play("move_dummy_to_half_exit", -1, 2)

func thank_player():
  dummy.connect("speak_finished", self, "move_dummy_to_exit", [], CONNECT_ONESHOT)
  dummy.speak(["Can you help me?", "Let's go!"])

func move_dummy_to_exit():
  animation.play("move_dummy_to_exit", -1, 2)

func start_game():
  get_tree().change_scene("res://scenes/MainScene.tscn")
