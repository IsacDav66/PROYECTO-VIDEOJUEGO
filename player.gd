extends CharacterBody2D

var Bala = preload("res://Bala.tscn")
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_up"):
		shootIce()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")
		#print("Jump")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h=true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h= false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
			#print("Run")
	
	else:
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
			#print("Idle")
	if velocity.y >0:
		anim.play("Fall")
		#print("Fall")
		
	move_and_slide()
	
	if Game.playerHP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://Main.tscn")


func  shootIce():
	var shoot_ice = Bala.instantiate()
	if $AnimatedSprite2D.flip_h:
		$Shoot.scale.x = -1
		shoot_ice.scale = Vector2(-2.3, 2.3)
		
	else:
		$Shoot.scale.x = 1
		shoot_ice.scale = Vector2(2.3, 2.3)
		
		
	shoot_ice.global_position = $Shoot/Direction.global_position
	get_tree().call_group("Mundo", "add_child", shoot_ice)
