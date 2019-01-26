extends Node

const Shovel = preload("res://Shovel.tscn")

export (NodePath) var dialog_target

func _ready():
	$SpawnTimer.connect("timeout", self, "spawn_shovels")
	$DialogTimer.connect("timeout", self, "spawn_dialog")
	Game.connect("score_changed", self, "_on_score_changed")
	
	Game.score = 0
	spawn_shovels()
	spawn_dialog()
	
func _on_score_changed(value):
	$GUI/Score.text = "Score: %s" % value
	
func spawn_shovels():
	$SpawnTimer.start(rand_range(1, 1.5))
	
	for i in int(rand_range(2, 5)):
		var x = rand_range(60, 550)
		var y = rand_range(-100, 100)
		var rotation = rand_range(-360, 360)
		var torque = rand_range(-500, 500)
		
		var shovel:RigidBody2D = Shovel.instance()
		add_child(shovel)
		shovel.position = Vector2(x, y)
		shovel.applied_torque = torque
		shovel.rotation_degrees = rotation
		shovel.apply_torque_impulse(torque)
	
func spawn_dialog():
	$DialogTimer.start(rand_range(5, 10))
	
	if not dialog_target: return
	
	Game.emit_signal("show_dialog", get_node(dialog_target))