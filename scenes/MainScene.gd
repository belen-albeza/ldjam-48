extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var hero := $Hero as Hero
onready var level := $Level as Level

const downstairs_lines := [
  "Let's go back home",
  "Mother must be worried",
  "I wonder what I did\nto anger the Elder Gods",
  "What I did wrong?\nI can't remember…",
  "This is going to take long…",
  "I miss Mother",
  "Was I a good elf?\nMaybe not",
  "I wonder what Ishar\nand Alyn are doing",
  "I feel lonely",
  "Why am I being punished?",
  "This doesn't feel right",
  "It's taking too long",
  "Mom, I miss you",
  "I wish I knew\nwhat I did"
]

var current_level_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  VisualServer.set_default_clear_color(Color.black)
  setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#  pass


func _on_Level_upstairs_entered() -> void:
  print("going upstairs")
  var lines = [
    "No point in going upwards",
    "Nope",
    "That's not the right way",
    "I need to go *down* instead"
  ]
  lines.shuffle()
  hero.speak([lines[0]])


func _on_Level_downstairs_entered(downstairs) -> void:
  print("going downstairs")
  var level_scene = downstairs.next_level
  hero.connect("speak_finished", self, "change_level", [level_scene], CONNECT_ONESHOT)
  var lines = downstairs_lines[current_level_index].split("\n")
  hero.speak(lines)


func setup_level():
  hero.global_position = level.get_starting_position()
  level.connect("downstairs_entered", self, "_on_Level_downstairs_entered")
  level.connect("upstairs_entered", self, "_on_Level_upstairs_entered")

func change_level(level_scene):
  if level_scene:
    level.queue_free()

    var new_level = (level_scene as PackedScene).instance()
    add_child(new_level)
    level = new_level

    setup_level()
    current_level_index += 1
  else:
    print("end game")
