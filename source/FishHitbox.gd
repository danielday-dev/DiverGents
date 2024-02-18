extends Area2D

func collidedWithPlayer(body : Node2D):
	
	set_collision_mask(0);
	
	# If player hits fish
	#if body.checkIfPlayerIsAttacking() and get_parent().get_parent().checkIsOnBeat():
	
	if body.checkIfPlayerIsAttacking():
		get_parent().spinIntoOblivion()
		$bonk.play()
	# If player doesnt hit fish, fish moves off and thats it
	
