extends Node
class_name PlayerStats

export(NodePath) var player_path
export(NodePath) var collision_area_path

onready var player = get_node(player_path)
onready var collision_area = get_node(collision_area_path)
onready var invencibility_timer = get_node("InvencibilityTimer")

var shielding: bool = false

var base_health: int = 15
var base_mana: int = 10
var base_attack: int = 100
var base_magic_attack: int = 3
var base_defense: int = 1

var bonus_health: int = 0
var bonus_mana: int = 0
var bonus_attack: int = 0
var bonus_magic_attack: int = 0
var bonus_defense: int = 0

var current_mana: int
var current_health: int

var max_health: int 
var max_mana: int 

var current_exp: int = 0

var level: int = 1

var level_dic: Dictionary = {
	"10": 435,
	"11": 546,
	"12": 681,
	"13": 845,
	"14": 1044,
	"15": 1285,
	"16": 1578,
	"17": 1933,
	"18": 2360,
	"19": 2871,
	"20": 3480,
	"21": 4203,
	"22": 5060,
	"23": 6073,
	"24": 7266,
	"25": 8665,
	"26": 10310,
	"27": 12243,
	"28": 14410,
	"29": 16860,
	"30": 19645,
	"31": 22821,
	"32": 26448,
	"33": 30589,
	"34": 35310,
	"35": 40681,
	"36": 46776,
	"37": 53673,
	"38": 61456,
	"39": 70215,
	"40": 80040,
	"41": 91033,
	"42": 103210,
	"43": 116793,
	"44": 131930,
	"45": 148785,
	"46": 167538,
	"47": 188381,
	"48": 211520,
	"49": 237185,
	"50": 265625,
	"51": 296105,
	"52": 328918,
	"53": 364369,
	"54": 402790,
	"55": 444536,
	"56": 489989,
	"57": 539558,
	"58": 593680,
	"59": 652824,
	"60": 717497,
	"61": 788239,
	"62": 865633,
	"63": 950302,
	"64": 1042761,
	"65": 1142616,
	"66": 1251320,
	"67": 1369526,
	"68": 1497915,
	"69": 1637313,
	"70": 1788609,
	"71": 1952765,
	"72": 2130826,
	"73": 2323913,
	"74": 2533228,
	"75": 2750078,
	"76": 2975860,
	"77": 3212045,
	"78": 3459991,
	"79": 3721011,
	"80": 3996476,
	"81": 4287818,
	"82": 4596535,
	"83": 4924161,
	"84": 5272273,
	"85": 5642488,
	"86": 6036483,
	"87": 6455991,
	"88": 6902808,
	"89": 7378805,
	"90": 7885930,
	"91": 8426193,
	"92": 9001686,
	"93": 9614595,
	"94": 10267413,
	"95": 10963585,
	"96": 11696383,
	"97": 12467139,
	"98": 13277245,
	"99": 14128100
}

func _ready() -> void:
	current_mana = base_mana + bonus_mana
	max_mana = current_mana
	
	current_health = base_health + bonus_health
	max_health = current_health
	
func update_exp(value: int) ->void:
	current_exp += value
	if current_exp >= level_dic[str(level)] and level < 9:
		var leftover: int = current_exp  - level_dic[str(level)]
		current_exp = leftover
		on_level_up()
		level += 1		
	if current_exp >= level_dic[str(level)] and level == 9:
		current_exp = level_dic[str(level)]
		
		
func on_level_up() -> void:
	current_mana = base_mana + bonus_mana
	current_health = base_health + bonus_health
	
func update_health(type: String, value: int) -> void:
	match type:
		"Increase":
			current_health += value
			if current_health > max_health:
				current_health = max_health
		"Decrease":
			verify_shield(value)
			if current_health <= 0:
				player.dead = true
			else:
				player.on_hit = true
				player.attacking = false
				
func update_mana(type: String, value: int) -> void:
	match type:
		"Increase":
			current_mana += value
			if current_mana > max_mana:
				current_mana = max_mana
		"Decrease":
			current_mana -= value

func verify_shield(value: int) -> void:
	if shielding:
		if (base_defense + bonus_defense) >= value:
			return
		var damage = abs((base_defense + bonus_defense) - value)
		current_health -= damage
	else:
		current_health -= value

func _process(_delta) -> void:
	pass

func on_Collision_area_entered(area):
	if area.name == "EnemyAttackArea":
		update_health("Decrease", area.damage)
		collision_area.set_deferred("monitoring", false)
		invencibility_timer.start(area.invencibility_timer)

func on_Invencibility_timer_timeout() -> void:
	collision_area.set_deferred("monitoring", true)
