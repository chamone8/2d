extends Area2D
class_name CollisionArea

export(NodePath) onready var enemy_path

onready var enemy = get_node(enemy_path)
onready var time: Timer = get_node("Timer")

export(int) var health
export(float) var invulnerability_time

func on_collision_area_entered(area):
	if area.get_parent() is PLayer:
		var player_stats: Node = area.get_parent().get_node("Stats")
		var player_attck: int = player_stats.base_attack + player_stats.bonus_attack
		
		update_health(player_attck)


func update_health(damage: int) -> void:
	health -= damage
	if health <= 0:
		enemy.can_die = true
		return
		
	enemy.can_hit = true
		
