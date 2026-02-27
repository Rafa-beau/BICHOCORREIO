class_name CardClass

var disapproved: bool
var approved: bool
var stamped: bool
var stamp_fake: bool
var is_anteat: bool
var is_crocs: bool
var ball: bool # BOLAS?!?!!
var water_stamp: bool
var bribe: bool
var dirty: bool
var water: bool
var paw_stamped: bool
var paw_approved: bool
var paw_disapproved: bool
var paw_water_stamp: bool


func _init(card, paw:=) -> void:
	disapproved = card.disapproved
	approved = card.approved
	stamped = card.stamped
	water_stamp = card.water_stamp
	stamp_fake = card.stamp_fake
	ball = card.ball
	bribe = card.bribe
	dirty = card.dirty
	water = card.water
	if paw:
		is_crocs = paw.Crocs
		is_anteat = paw.AntEat
		paw_stamped = paw.paw_stamped
		paw_approved = paw.paw_approved
		paw_disapproved = paw.paw_disapproved
		paw_water_stamp = paw.paw_water_stamp

func print_all():
	print(disapproved,
	approved,
	stamped ,
	is_anteat,
	is_crocs,
	ball,
	water_stamp,
	bribe,
	dirty,
	water,
	paw_stamped,
	paw_approved, 
	paw_disapproved, 
	paw_water_stamp,
)
