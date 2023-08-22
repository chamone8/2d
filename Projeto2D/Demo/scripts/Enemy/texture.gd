extends Sprite
class_name EnemyTexture

export(NodePath) var animation_path
export(NodePath) var enemy_path
export(NodePath) var attack_area_collision_path

onready var animation = get_node(animation_path)
onready var enemy = get_node(enemy_path)
onready var attack_area_collision = get_node(attack_area_collision_path)



func animate(_velocity: Vector2) -> void:
	pass
	
func _on_animation_finished(_anim_name: String) -> void:
	pass
