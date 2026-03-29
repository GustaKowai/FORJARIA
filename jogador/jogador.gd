class_name Jogador
extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var dash_timer: Timer = $Timer
@onready var maos: Sprite2D = $Sprite2D/Maos
const MAODEMAO = preload("res://jogador/animacoesplayer/maodemao.png")
const MARTELO = preload("res://jogador/animacoesplayer/martelo.png")
const TESOURA = preload("res://jogador/animacoesplayer/tesoura.png")

@export_category("Movement")
@export var speed:float = 3.0
@export_range(0,1) var lerp_smoothness:float = 0.5
@export var dash_duration:float = 0.1
@export var dash_boost:float = 8.0
@export var stamina_recovery_speed:float = 20.0
@export var max_stamina:int = 100
@export var dash_cost:int = 70
var stamina_value:float = 0.0
var is_dashing:bool = false
var is_playing:bool = false

var input_vector:Vector2 = Vector2(0,0)
var position_running:String = "down"

func _ready():
	GameManager.mini_game_start.connect(jogando)
	GameManager.exit_minigame.connect(nao_jogando)
	GerenciadorItens.drop_item.connect(drop_item)
	GameManager.mao_animacao.connect(muda_mao)
	
func _process(delta):
	#GameManager.player_position = global_position
	#Obtem o vetor de input:
	input_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	play_run_iddle()
	#if not is_playing:
		#rotate_sprite()
	


func _input(event: InputEvent) -> void:
#	if Input.is_action_just_pressed("Dash") and not is_playing:
		#dash()
	pass
	
func _physics_process(_delta):
	if is_playing: return
	sprite.look_at(get_global_mouse_position())
	var target_velocity:Vector2 = input_vector*speed*100.0
	velocity = lerp(velocity,target_velocity,lerp_smoothness)
	move_and_slide()


#region Funções do dash:
func dash():
	if not is_dashing and stamina_value >= dash_cost:
		is_dashing = true
		var dash_speed:float = speed + dash_boost
		stamina_value -= dash_cost
		self.set_collision_mask_value(2, false)
		self.modulate.a = 0.5
		#Mudança sutil de velocidade
		var velocity_tween:Tween = create_tween()
		velocity_tween.set_ease(Tween.EASE_IN)
		velocity_tween.tween_property(self, "speed", dash_speed, dash_duration/2)
		velocity_tween.tween_property(self, "speed", dash_speed, dash_duration/2)
		dash_timer.wait_time = dash_duration
		dash_timer.start()
		
func _on_timer_timeout() -> void:
	stop_dash()
		
func stop_dash():
	is_dashing = false
	var pos_dash_speed:float = speed - dash_boost
	self.modulate.a = 1.0
	var velocity_tween:Tween = create_tween()
	velocity_tween.set_ease(Tween.EASE_IN)
	velocity_tween.tween_property(self, "speed", pos_dash_speed, dash_duration/2)
	velocity_tween.tween_property(self, "speed", pos_dash_speed, dash_duration/2)
		
func recharg_stamina(delta):
	if stamina_value < max_stamina:
		stamina_value += delta*stamina_recovery_speed
#endregion

#Funções de movimento:	
func play_run_iddle():
#Checa se o personagem está correndo
	if velocity.is_zero_approx():
		animation_player.play("Idle") 	
	else:
		animation_player.play("Move")

#func rotate_sprite():
	##girar sprite:
	#if input_vector.x < 0:
		#sprite.flip_h = false
	#elif input_vector.x > 0:
		#sprite.flip_h = true

func jogando():
	is_playing = true
	print_debug("jogando ",is_playing)
	
func nao_jogando():
	is_playing=false

func drop_item(slot):
	var objeto = GerenciadorItens.inventario[slot]
	print_debug(objeto)
	objeto.global_position = global_position
	get_parent().add_child(objeto)
	GerenciadorItens.inventario[slot] = null
	GerenciadorItens.item_dropado.emit(slot)

func muda_mao(mao):
	match mao:
		"mao tesoura":
			maos.texture = TESOURA
		"mao martelo":
			maos.texture = MARTELO
		"mao de mao":
			maos.texture = MAODEMAO
		_:
			maos.texture = null 
