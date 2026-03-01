extends Node

func can_accept(c: CardClass) -> bool:
	if c.stamp_fake:
		return false
	if c.bribe:
		return false
	if c.ball:
		return false
	if c.disapproved:
		return false
	if c.is_anteat:
		return false
	if c.is_crocs:
		return false
	if c.water and c.water_stamp and c.approved:
		return true
	if not c.water and c.stamped and c.approved:
		return true
	return false


func can_confiscate(c: CardClass) -> bool:
	if c.stamp_fake:
		return true
	if c.paw_approved:
		return false
	if c.approved:
		return false
	# BOOOOOOOOOOOOOLAAAAAAAAAAAAAAAAAAAS???!!!???
	if c.ball:
		return true
	if c.bribe:
		return true
	if c.is_anteat and c.disapproved and c.paw_disapproved:
		return true
	if c.is_crocs and c.disapproved and c.paw_disapproved:
		return true
	
	return false
