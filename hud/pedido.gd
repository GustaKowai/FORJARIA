extends MarginContainer

@onready var texto_do_pedido: Label = %"Texto do pedido"
@onready var paciencia: Label = %paciencia

var lamina_tamanho:String
var cabo_tamanho:String
var paciencia_cliente:float = 5
@export var velocidade_paciencia:float = 0.1
@onready var acerto: AudioStreamPlayer = $Acerto
@onready var erro: AudioStreamPlayer = $erro
@onready var paciencia_barra: ProgressBar = %paciencia_barra


func _ready() -> void:
	GameManager.fim_do_dia.connect(fim_do_dia)
	var lamina = randi_range(1,3)
	var cabo = randi_range(1,3)
	lamina_tamanho = resultado_sorteio(lamina)
	cabo_tamanho = resultado_sorteio(cabo)
	
	texto_do_pedido.text = "Eu quero uma lamina de tamanho "+lamina_tamanho+" e um cabo "+cabo_tamanho
	
func _process(delta: float) -> void:
	if paciencia_cliente >= 1.1:
		paciencia_cliente -=delta*velocidade_paciencia
		paciencia.text = str(ceil(paciencia_cliente))
		paciencia_barra.value = ceil(paciencia_cliente)
		#print_debug(paciencia_barra.value)
		#var fill = paciencia_barra.get_theme_stylebox("fill")
		#match paciencia_barra.value:
			#5.0:
				#fill.bg_color = Color.BLUE
			#4.0:
				#fill.bg_color = Color.GREEN
			#3.0:
				#fill.bg_color = Color.YELLOW
			#2.0:
				#fill.bg_color = Color.ORANGE
			#_:
				#fill.bg_color = Color.RED
	else:
		paciencia_cliente = 1
		paciencia.text = "1"
		paciencia_barra.value = ceil(paciencia_cliente)
		#var fill = paciencia_barra.get_theme_stylebox("fill")
		#fill.bg_color = Color.RED
	
func resultado_sorteio(sorteio):
	var resultado
	match sorteio:
		1:
			resultado = "pequeno"
		2:
			resultado = "médio"
		3:
			resultado = "grande"
			
	return resultado


func _on_panel_container_mouse_entered() -> void:
	modulate = Color(2.0,1.1,1.1)

func _on_panel_container_mouse_exited() -> void:
	modulate = Color(1.0,1.0,1.0)

func _on_panel_container_gui_input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if GerenciadorItens.inventario[0] != null:
			if GerenciadorItens.inventario[0].item_name == "espada":
				var espada:Espada = GerenciadorItens.inventario[0]
				GerenciadorItens.inventario[0] = null
				GerenciadorItens.item_dropado.emit(0)
				if espada.tamanho_cabo == cabo_tamanho and espada.tamanho_lamina == lamina_tamanho:
					print_debug("Está correto")
					GameManager.pedidos_corretos += 1
					print_debug(espada.qualidade)
					GameManager.fama += espada.qualidade*ceil(paciencia_cliente)
					GameManager.muda_fama.emit(int(espada.qualidade*ceil(paciencia_cliente)))
					GameManager.ouro += espada.qualidade*ceil(paciencia_cliente)
					GameManager.muda_ouro.emit(int(espada.qualidade*ceil(paciencia_cliente)))
					acerto.play()
					GameManager.pedido_entrou_saiu.emit(-1)
					modulate = Color.GREEN
				else:
					print_debug("Está errado")
					GameManager.pedidos_errados += 1
					GameManager.fama -= 100*(6-floor(paciencia_cliente))
					GameManager.muda_fama.emit(-100*(6-floor(paciencia_cliente)))
					erro.play()
					GameManager.pedido_entrou_saiu.emit(-1)
					modulate = Color.RED
					

func fim_do_dia():
	print_debug("Você não fez meu pedido!!")
	GameManager.pedidos_incompletos += 1
	GameManager.fama -= 20*(6-floor(paciencia_cliente))
	GameManager.muda_fama.emit(-10*(6-floor(paciencia_cliente)))
	GameManager.pedido_entrou_saiu.emit(-1)
	queue_free()


func _on_acerto_finished() -> void:
	queue_free()


func _on_erro_finished() -> void:
	queue_free()
