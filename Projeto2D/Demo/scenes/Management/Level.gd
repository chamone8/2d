extends Node2D
class_name Level

onready var player: KinematicBody2D = get_node("Layer")

func _ready():
	var _game_over: bool = player.get_node("Teture").connect("game_over", self, "on_game_over")
	
func on_game_over() -> void:
	var _reload: bool = get_tree().reload_current_scene()