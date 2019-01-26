extends PanelContainer

func _ready():
	set_process(false)

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().paused = false
		set_process(false)
		get_tree().reload_current_scene()
		