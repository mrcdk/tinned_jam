extends PanelContainer

var target = null

func _ready():
	Game.connect("show_dialog", self, "_on_show_dialog")
	
func _process(delta):
	if not visible or not target: return
	
	rect_position = target.global_position
	rect_position.x -= rect_size.x / 2
	rect_position.y -= rect_size.y
	
	var rect = Rect2(rect_position, rect_size)
	
	if rect.position.x < 0:
		rect.position.x = 0
	elif rect.end.x > 640:
		rect.position.x -= rect.end.x - 640
		
	if rect.position.y < 0:
		rect.position.y = 0
	elif rect.end.y > 480:
		rect.position.y -= rect.end.y - 480
		
	rect_position = rect.position
	
func _on_show_dialog(target):
	self.target = target
	$AnimationPlayer.play("hide")
	yield($AnimationPlayer, "animation_finished")
	$VBoxContainer/Content.text = Game.shovel_facts[randi() % Game.shovel_facts.size()]
	$AnimationPlayer.play("show")