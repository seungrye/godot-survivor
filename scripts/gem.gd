extends Pickups
class_name Gem

@export var xp: float

func activate():
	super.activate()
	prints('+' + str(xp) + 'XP')
	self.player_reference.gain_xp(xp)
