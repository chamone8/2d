extends Area2D
class_name DetectionArea

export(NodePath) var enemy_path

onready var enemy = get_node(enemy_path)




func on_body_entered(body: PLayer) -> void:
		enemy.player_ref = body


func on_body_exited(_body: PLayer) -> void:
	enemy.player_ref = null
