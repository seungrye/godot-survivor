extends VBoxContainer

@export var weapons: HBoxContainer
var OptionSlot = preload("res://scenes/option_slot_texture_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()

func close_option():
	self.hide()
	get_tree().paused = false

func show_option():
	var option_slot = OptionSlot.instantiate()
	self.add_child(option_slot)
	
	self.show()
	get_tree().paused = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
