extends Node2D

@export var speed = 0.5
var jogador:Jogador
var sprite:Sprite2D
var animation_player:AnimationPlayer
var var_diff:Vector2
var position_running = "side" 
var nav_agent:NavigationAgent2D
var knockback_direction:Vector2 = Vector2(0,0)
var ponto_final_alcancado:bool = true

func _ready():
	jogador = get_parent()
	sprite =jogador.get_node("Sprite2D")
	animation_player = jogador.get_node("AnimationPlayer")
	nav_agent = get_node("NavigationAgent2D")
	

func _physics_process(_delta:float):
	if GameManager.is_game_over: return
	
	var_diff = to_local(nav_agent.get_next_path_position()) #pega o próximo ponto do caminho calculado para o jogador
	if not ponto_final_alcancado:
		move()
		
func move():
	var normalize_diffe = var_diff.normalized() #Transforma o vetor apontando para o próximo ponto em um versor
	var input_vector = normalize_diffe 
	jogador.velocity = input_vector * speed * 100.0
	#Determinar qual animação será usada:
	if abs(var_diff.x) >= abs(var_diff.y):
		position_running = "side"
		#animation_player.play("Walk Side")
		#girar sprite:
		if input_vector.x > 0:
			sprite.flip_h = false
		elif input_vector.x <0:
			sprite.flip_h = true
	elif var_diff.y < 0:
		position_running = "up"
		#animation_player.play("Walk Up")
	else:
		position_running = "down"
		#animation_player.play("Walk Down")
		
	jogador.position_running = position_running
	jogador.move_and_slide()
	
func make_path(): #Calcula e cria o melhor caminho até o jogador, desviando de obstáculos
	#var player_position = GameManager.player_position
	nav_agent.target_position = get_global_mouse_position()
		
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#print_debug(jogador.is_playing)
		if not jogador.is_playing:
			make_path()
			ponto_final_alcancado = false


func _on_navigation_agent_2d_navigation_finished() -> void:
	ponto_final_alcancado = true
