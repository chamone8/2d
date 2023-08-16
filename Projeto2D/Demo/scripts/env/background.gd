extends ParallaxBackground
class_name Background

export(bool) var can_process
export (Array, int) var layer_speed


func _ready():
	if can_process == false:
		set_physics_process(false)


func _physics_process(delta):
	for index in range(get_child_count()):
		var child = get_child(index)
		if child is ParallaxLayer:
			var offset = child.motion_offset
			offset.x -= delta * layer_speed[index]
			child.motion_offset = offset
