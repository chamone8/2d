extends KinematicBody2D
class_name PLayer

onready var player_sprite: Sprite = get_node("Teture")
onready var wall_ray: RayCast2D = get_node("WallRay")
onready var stats: Node = get_node("Stats")

#variaveis
var on_hit: bool = false
var dead: bool = false
var velocity: Vector2 #(150,150)
var jump_count: int = 0
var on_wall: bool = false
var landing: bool = false
var attacking: bool = false
var defending: bool = false
var crouching: bool = false
var direction: int = 1
# Variavel para caso o personagem esteja defendendo ou atacando ou agachado ele não consiga se mover
var can_track_input: bool = true 
var not_on_wall: bool = true


# exports
export(int) var speed
export(int) var jump_speed
export(int) var player_gravity
export(int) var wall_jump_speed
export(int) var wall_gravity
export(int) var wall_impulse_speed

func _physics_process(delta: float):
	horizontal_movement_eve()
	vertical_movement_env()
	actions_env()
	
	gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	player_sprite.animate(velocity)
	
func horizontal_movement_eve() -> void:
	var input_direction: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if can_track_input == false or attacking:
		velocity.x = 0
		return 
		
	velocity.x = input_direction * speed
	
func vertical_movement_env() ->void:
	if is_on_floor() or is_on_wall():
		jump_count = 0
	
	var jump_condicion: bool = can_track_input and not attacking
	if Input.is_action_just_pressed("ui_select") and jump_count <2 and jump_condicion:
		jump_count += 1
		if next_to_wall() and not is_on_floor():
			velocity.y = wall_impulse_speed
			velocity.x = wall_impulse_speed * direction
		velocity.y = jump_speed

func actions_env() -> void:
	attack()
	crouch()
	defense()

func attack() -> void:
	var attack_condition: bool = not attacking and not crouching and not defending
	if Input.is_action_just_pressed("attack") and attack_condition and is_on_floor():
		attacking = true
		player_sprite.normal_attack = true
	
func crouch() -> void:
	if Input.is_action_pressed("crouch") and not defending and is_on_floor():
		crouching = true
		stats.shielding = false
		can_track_input = false
	elif not defending:
		crouching = false
		stats.shielding = false
		can_track_input = true
		player_sprite.crouching_off = true

func defense() -> void:
	if Input.is_action_pressed("defense") and is_on_floor() and not crouching:
		defending = true
		stats.shielding = true
		can_track_input = false
	elif not crouching:
		defending = false
		stats.shielding = false
		can_track_input = true
		player_sprite.shield_off = true

func next_to_wall() -> bool:
	if wall_ray.is_colliding() and not is_on_floor():
		if not_on_wall:
			velocity.y = 0
			not_on_wall = false	
		return true
	else:
		not_on_wall = true
		return false
		
func gravity(delta: float) -> void:
	if next_to_wall():
		velocity.y += delta * wall_gravity
		if velocity.y > wall_gravity:
			velocity.y = wall_gravity
	else:		
		velocity.y += delta * player_gravity
		if velocity.y >= player_gravity:
			velocity.y = player_gravity
