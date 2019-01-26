extends RigidBody2D

var player_touched := false

func _ready():
	physics_material_override.friction = rand_range(0.1, 0.7)
	physics_material_override.bounce = rand_range(0.3, 0.8)

func _on_Shovel_body_entered(body):
	if not player_touched and body.is_in_group("player"):
		player_touched = true
		
	if body.is_in_group("shovel") and body.player_touched:
		player_touched = true


func _on_VisibilityNotifier2D_screen_exited():
	if player_touched:
		Game.score += 100
	
	queue_free()
