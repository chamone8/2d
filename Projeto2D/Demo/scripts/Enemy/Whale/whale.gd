extends EnemyTemplete
class_name Whale

func _ready() -> void:
	randomize()
	drop_list = {
		"Heal Potion" : [
			"res://assets/item/consumable/health_potion.png", # Caminho
			20, # Pocentagem
			"Health", # Tipo
			5, # Quantidade de heal a ser recuperado
			2  # Valor Venda	
		],
		 "Mana Potion" : [
			"res://assets/item/consumable/mana_potion.png",
			15,
			"Mana",
			5,
			5
		],
		"Whale Mouth":[
			"res://assets/item/resource/whale/whale_mouth.png",
			45,
			"Resource",
			{},
			2
		],
		"Whale Eye":[
			"res://assets/item/resource/whale/whale_eye.png",
			15,
			"Resource",
			{},
			6
		],
		"Whale Tall":[
			"res://assets/item/resource/whale/whale_tail.png",
			3,
			"Resource",
			{},
			25
		],
		"Whale Mask":[
			"res://assets/item/equipment/whale_mask.png",
			3,
			"Resource",
			{
				"Mana": 5,
				"Magic Attack": 3
			},
			25
		]
	}
