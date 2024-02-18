extends Area2D

var inPlayer : bool = false;
var playerAttacked : bool = false;
var player : Node2D;

var tolerenceStart : bool = false;
var tolerence : float = 0.2; # Measured in seconds.

func collidedWithPlayer(body : Node2D):
	inPlayer = true;
	player = body;
	set_collision_mask(0);
	
func _process(delta):
	if (!inPlayer):
		return;

	# Check for attack at any active stage (collision -> on beat -> tolerence).
	if (player.checkIfPlayerIsAttacking()):
		playerAttacked = true;
	
	# Fishy can die only die on beat (with tolerence).
	if get_parent().get_parent().checkIsOnBeat():
		tolerenceStart = true;
 
	# Death with dig-- tolerence.
	if (tolerenceStart):
		tolerence -= delta;
		if (playerAttacked):    
			inPlayer = false;
			get_parent().spinIntoOblivion();
			$bonk.play();
		elif  tolerence <= 0 :
			inPlayer = false;
			
			
