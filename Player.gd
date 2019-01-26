extends KinematicBody2D

export (float) var walk_speed = 150
export (float) var run_speed = 300
export (float) var jump_speed = 450
export (Vector2) var gravity = Vector2(0, 900)

onready var Model = $Model

onready var SpriteAnimationPlayer = $Model/AnimationPivot/AnimationPlayer
onready var MoveAnimationPlayer = $MoveAnimationPlayer
onready var FacingAnimationPlayer = $FacingAnimationPlayer
onready var JumpingAnimationPlayer = $JumpingAnimationPlayer

onready var ShadowRayCastLeft = $ShadowRayCastLeft
onready var ShadowRayCastRight = $ShadowRayCastRight
onready var Shadow = $Shadow

var linear_velocity := Vector2()

func _ready():
	pass
	
func _physics_process(delta):
	
	#MOVEMENT
	
	# gravity
	linear_velocity += gravity * delta
	
	linear_velocity = move_and_slide(linear_velocity, Vector2.UP, false, 4, 0.78, true)
	
	for index in get_slide_count():
		var body = get_slide_collision(index)
		if body.collider is RigidBody2D:
			print(body.collider)
	
	var motion := Vector2()
	
	if Input.is_action_pressed("right"):
		motion.x += 1
		
	if Input.is_action_pressed("left"):
		motion.x -= 1
		
	# horizontal speed
		
	var speed = walk_speed
	var is_running = false
	if Input.is_action_pressed("run"):
		speed = run_speed
		is_running = true
		
	var target_speed = motion * speed
	linear_velocity.x = lerp(linear_velocity.x, target_speed.x, 0.25)
	
	# jump
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		linear_velocity.y = -jump_speed
		
	# SHADOW POSITION
	
	var shadow_position:Vector2 = Model.position + Vector2(0, 20)
	
	var shadow_left = shadow_position
	if ShadowRayCastLeft.is_colliding():
		shadow_left = Vector2(0, to_local(ShadowRayCastLeft.get_collision_point()).y)
		
	var shadow_right = shadow_position
	if ShadowRayCastRight.is_colliding():
		shadow_right = Vector2(0, to_local(ShadowRayCastRight.get_collision_point()).y)
	
	if shadow_left.length_squared() <= shadow_right.length_squared():
		shadow_position = shadow_left
	else:
		shadow_position = shadow_right
		
	var shadow_dist = shadow_position.y - Model.position.y - 20
	shadow_dist = clamp(range_lerp(shadow_dist, 0, 200, 1, 0.7), 0.7, 1)
	
	Shadow.position = shadow_position
	Shadow.scale = Vector2(shadow_dist, shadow_dist)
	
		
	# ANIMATION
		
	var is_moving = abs(motion.x) > 0
	if is_moving:
		var face_anim = "face_left" if motion.x > 0 else "face_right"
		if not FacingAnimationPlayer.current_animation == face_anim:
			FacingAnimationPlayer.play(face_anim)
			
		var anim = "walk" if not is_running else "run"
		if not MoveAnimationPlayer.current_animation == anim:
			MoveAnimationPlayer.play(anim)
	else:
		MoveAnimationPlayer.play("idle")
		
	var jumping_anim = "idle"
	if linear_velocity.y > 0:
		jumping_anim = "jump_down"
	elif linear_velocity.y < 0:
		jumping_anim = "jump_up"
	else:
		jumping_anim = "idle"
		
	if not JumpingAnimationPlayer.current_animation == jumping_anim:
		JumpingAnimationPlayer.play(jumping_anim)