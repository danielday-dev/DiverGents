extends CharacterBody2D

var moveSpeed : float;

func _physics_process(delta):
	velocity.y = moveSpeed;
	move_and_slide()


func collidedWithPlayer(body : Node2D):
	
	set_collision_mask(0);
	
	# If player hits fish
	#if body.checkIfPlayerIsAttacking() and get_parent().get_parent().checkIsOnBeat():
	
	get_tree().change_scene_to_file("res://scenes/WinScreen.tscn");
