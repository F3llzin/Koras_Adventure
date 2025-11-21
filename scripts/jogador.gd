extends CharacterBody2D


const SPEED = 150.0
const FRICCAO_AR = 0.5
var knockback = Vector2.ZERO
var knockback_power = 20 
@onready var animation = $anim as AnimatedSprite2D
@onready var pular = $pular as AudioStreamPlayer
@onready var remote_transform = $RemoteTransform2D
@onready var ray_direita = $Ray_direita
@onready var ray_esquerda = $Ray_esquerda
var direction
var direcao

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var jump_height = 72
@export var max_time_to_peak = 0.5

var jump_velocity
var gravity 
var fall_gravity

var pulando = false
var is_hurted = false

signal jogador_morreu

func _ready():
	jump_velocity = (jump_height * 2) / max_time_to_peak
	gravity = (jump_height * 2) / (max_time_to_peak * max_time_to_peak)
	fall_gravity = gravity * 2

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.x = 0
		#velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -jump_velocity
		pulando = true
		pular.play()
	elif is_on_floor():
		pulando = false
		
	if velocity.y > 0 or not Input.is_action_pressed("ui_accept"):
		velocity.y += fall_gravity * delta
	else:
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	direcao = Input.get_axis("mov._direita", "mov._esquerda")
	
	if direction:
		velocity.x = lerp(velocity.x, direction * SPEED, FRICCAO_AR)
		animation.scale.x = direction
	
	elif direcao:
		velocity.x = lerp(velocity.x, direcao * SPEED, FRICCAO_AR)
		animation.scale.x = direcao
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if knockback != Vector2.ZERO:
		velocity = knockback

	_set_state()
	move_and_slide()

	for platforms in get_slide_collision_count():
		var colisao = get_slide_collision(platforms)
		if colisao.get_collider().has_method("colidiu_com"):
			colisao.get_collider().colidiu_com(colisao, self)


func _on_hurt_box_body_entered(_body):
	var knock = Vector2((global_position.x - _body.global_position.x) * knockback_power, -200)
	tomar_dano(knock)
		
func seguir_camera(camera_2d):
	var caminho_camera = camera_2d.get_path()
	remote_transform.remote_path = caminho_camera
	
func tomar_dano(knockback_force = Vector2.ZERO, duration = 0.3):
	if Global.vida_jogador > 0:
		Global.vida_jogador -= 1
	else:
		queue_free()
		emit_signal("jogador_morreu")
	if knockback_force != Vector2.ZERO:
		knockback = knockback_force 
		
		var knockback_tween = get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback", Vector2.ZERO, duration)
		animation.modulate = Color(1,0,0,1)
		knockback_tween.parallel().tween_property(animation, "modulate", Color(1,1,1,1), duration)
		
	is_hurted = true
	await get_tree().create_timer(0.3).timeout
	is_hurted = false
		
func _set_state():
	var state = "idle"
	
	if !is_on_floor():
		state = "jump"
	elif direction != 0:
		state = "run"
	elif direcao != 0:
		state = "run"
	if is_hurted:
		state = "hurt"
	
	if animation.name != state:
		animation.play(state)
		

			
func death_fall_zone():
	if Global.vida_jogador >= 0:
		visible = false
		set_physics_process(false)
		await get_tree().create_timer(1.0).timeout
		Global.respawn_player()
		visible = true
		set_physics_process(true)
	else:
		visible = false
		await get_tree().create_timer(0.5).timeout
		jogador_morreu.emit()

func chegada():
	visible = false
	set_physics_process(false)
	
func final_jogo():
	visible = false
	set_physics_process(false)

func _input(event):
	if event is InputEventScreenTouch:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = -jump_velocity
			pulando = true
			pular.play()
		elif is_on_floor():
			pulando = false
