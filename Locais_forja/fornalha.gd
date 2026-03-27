extends Node2D
var soprador:bool
var carvao:bool
@onready var combustivel: ProgressBar = $Combustivel
@onready var temperatura: ProgressBar = $Temperatura
@onready var forja_sprite: AnimatedSprite2D = $forja
@export var variacao_temperatura:float
@export var velocidade_queima:float
@onready var seta_soprador: Node2D = $SetaSoprador
@onready var seta_minerio: Node2D = $SetaMinerio
@onready var seta_carvao: Node2D = $SetaCarvao

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	temperatura.value -= variacao_temperatura*delta
	combustivel.value -= temperatura.value*velocidade_queima*delta
	forja_sprite.speed_scale = temperatura.value/100

#region soprador da forja
func _on_area_soprador_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		seta_soprador.visible = true
		soprador = true
		print_debug(body)


func _on_area_soprador_body_exited(body: Node2D) -> void:
	seta_soprador.visible = false
	soprador = false


func _on_area_soprador_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and soprador and combustivel.value!=0:
		if temperatura.value < 100:
			temperatura.value += 20

#endregion

#region colocar carvao
func _on_area_carvao_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		seta_carvao.visible = true
		carvao = true
		print_debug(body)


func _on_area_carvao_body_exited(body: Node2D) -> void:
	seta_carvao.visible = false
	carvao = false


func _on_area_carvao_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and carvao and GerenciadorItens.inventario[0] != null:
		if GerenciadorItens.inventario[0].item_name == "carvão":
			if combustivel.value < 1000:
				combustivel.value += 200
				GerenciadorItens.inventario[0] = null
				GerenciadorItens.item_dropado.emit(0)
#endregion
