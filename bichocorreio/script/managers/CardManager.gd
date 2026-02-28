extends Node

func can_accept(c: CardClass) -> bool:
	if c.bribe:
		return false
	if c.ball:
		return false
	if c.disapproved:
		return false
	if c.stamped and not c.paw_stamped and not c.stamp_fake:
		if c.water:
			if c.water_stamp and c.approved:
				return true
			return false
		
		if not c.is_anteat:
			if not c.water_stamp and c.approved:
				return true
		
		c.print_all()
		return false
	
	c.print_all()
	return false


func can_confiscate(c: CardClass) -> bool:
	if c.paw_approved:
		return false
	if c.approved:
		return false
	# BOOOOOOOOOOOOOLAAAAAAAAAAAAAAAAAAAS???!!!???
	if c.ball:
		return true
	
	if c.stamp_fake:
		if (c.is_anteat or c.is_crocs) and c.paw_stamped and c.paw_disapproved:
			return true
		return true
	
	if c.stamped and c.disapproved:
		if (c.is_anteat or c.is_crocs) and c.paw_stamped and c.paw_disapproved:
			return true
		if c.bribe:
			return true
		
		c.print_all()
		return false
	
	return false
