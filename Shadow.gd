extends Node2D

export (Vector2) var base_scale = Vector2(1, 1)
export (NodePath) var exclude_path

onready var RayCastLeft = $RayCastLeft
onready var RayCastRight = $RayCastRight

func _ready():
	if exclude_path:
		var exclude = get_node(exclude_path)
		RayCastLeft.add_exception(exclude)
		RayCastRight.add_exception(exclude)

func _physics_process(delta):
	var shadow_position:Vector2 = position
	
	var shadow_left = shadow_position
	if RayCastLeft.is_colliding():
		shadow_left = Vector2(0, to_local(RayCastLeft.get_collision_point()).y)
		
	var shadow_right = shadow_position
	if RayCastRight.is_colliding():
		shadow_right = Vector2(0, to_local(RayCastRight.get_collision_point()).y)
	
	if shadow_left.length_squared() <= shadow_right.length_squared():
		shadow_position = shadow_left
	else:
		shadow_position = shadow_right
		
	var shadow_dist = shadow_position.y - position.y
	shadow_dist = clamp(range_lerp(shadow_dist, 0, 150, 1, 0.7), 0.7, 1)
	
	position = shadow_position
	scale = Vector2(shadow_dist, shadow_dist)