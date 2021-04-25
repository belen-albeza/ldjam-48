extends Node2D

onready var hero := $Hero as Hero
onready var level := $Level as Level

var key_amount := 0 setget set_key_amount

const downstairs_lines := [
  "Let's go back home",
  "Mother must be worried",
  "I wonder what I did\nto anger the Elder Gods",
  "What I did wrong?\nI can't remember…",
  "The deeper I go,\nThe closer I get",
  "I miss Mother",
  "Was I a good elf?\nMaybe not",
  "I wonder what Ishar\nand Alyn are doing",
  "I feel lonely",
  "Why am I being punished?",
  "I wish I knew what I did",
  "Will I ever\nbe forgiven?",
  "Mom, I promise…\nI promise I was good",
]

var current_level_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  VisualServer.set_default_clear_color(Color.black)
  setup_level()

  hero.speak([
    "Is this…",
    "the surface?",
    "What…",
    "I just remember",
    "being punished",
    "by the Gods…",
    "Why?",
    "I need to go back",
    "to the Underground",
  ])
  self.key_amount = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#  pass

func set_key_amount(value: int) -> void:
  key_amount = value
  ($UI/Inventory/HBoxContainer/Label as Label).text = "%sx" % key_amount

func _on_Level_upstairs_entered() -> void:
  var lines = [
    "No point in going upwards",
    "Nope",
    "That's not the right way",
    "I need to go *down* instead",
    "The Gods will get angry"
  ]
  lines.shuffle()
  hero.speak([lines[0]])


func _on_Level_downstairs_entered(downstairs) -> void:
  var level_scene = downstairs.next_level
# warning-ignore:return_value_discarded
  hero.connect("speak_finished", self, "change_level", [level_scene], CONNECT_ONESHOT)
  var lines = downstairs_lines[current_level_index].split("\n")
  hero.speak(lines)


func setup_level():
  hero.global_position = level.get_starting_position()
# warning-ignore:return_value_discarded
  level.connect("downstairs_entered", self, "_on_Level_downstairs_entered")
# warning-ignore:return_value_discarded
  level.connect("upstairs_entered", self, "_on_Level_upstairs_entered")

func change_level(level_scene):
  if current_level_index < len(downstairs_lines) - 1:
    if level_scene == null:
      level_scene = load("res://scenes/Level01.tscn")
    level.queue_free()

    var new_level = (level_scene as PackedScene).instance()
    add_child(new_level)
    level = new_level

    setup_level()
    current_level_index += 1
  else:
# warning-ignore:return_value_discarded
    get_tree().change_scene("res://ui/EndScene.tscn")


func _on_Hero_item_picked_up(what: int) -> void:
  if what == Hero.Item.KEY:
    self.key_amount += 1


func _on_Hero_door_collided(door: Node2D) -> void:
  if key_amount > 0:
    door.queue_free()
    self.key_amount -= 1
    ($SfxDoor as AudioStreamPlayer).play()
  else:
    hero.speak(["I need a key."])
