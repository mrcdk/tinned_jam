extends Node

signal score_changed(new_value)
signal combo_changed(new_value)
signal show_dialog(to_follow)

var score = 0 setget _set_score
var combo = 0 setget _set_combo

var shovel_facts = [
"Shovels are tools that are primarily used to move or dig substances such as dirt or sand. But these ones only bounce.",
"Shovels are basically a long rod, sometimes with a handle, with a somewhat flat scoop on the end. These are just sprites.",
"Shovels are commonly used in landscaping, building or farming. Not these ones tho.",
"Shovels are typically made of steel or tough plastic, with a fibreglass or wooden handle. These ones are made of pixels.",
"Throughout history, animal bones, particularly the shoulder blade, have been used like a shovel. I'm just a sponge so I'm okay with that.",
"In the 1900s, advancements in machinery started to replace shovels. Modern shovels are sad.",
"In 1967, a wooden shovel from approximately 2000 BC was discovered in Turkey. The primordial shovel they call it.",
"There are many types of shovels; some are used to pry open items, dig holes, and scoop away snow or coal. There's only ONE shovel sprite.",
"Shovels range in size and shape; some are square, while others are small, and some have sharp blades. These ones are sprite sized.",
"Some shovels are designed to collapse and be easily stored, and are often used by the military or campers. These ones bounce a lot (maybe).",
]

func _ready():
	randomize()
	
func _set_score(new_score):
	score = new_score
	emit_signal("score_changed", score)
	
func _set_combo(new_combo):
	combo = new_combo
	emit_signal("combo_changed", combo)