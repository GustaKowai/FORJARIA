extends Node2D
var soprador:bool
var carvao:bool
@onready var combustivel: ProgressBar = $Combustivel
@onready var temperatura: ProgressBar = $Temperatura
@onready var forja_sprite: AnimatedSprite2D = $forja
@export var variacao_temperatura:float
@export var velocidade_queima:float
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
		soprador = true
		print_debug(body)


func _on_area_soprador_body_exited(body: Node2D) -> void:
	soprador = false


func _on_area_soprador_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and soprador and combustivel.value!=0:
		if temperatura.value < 100:
			temperatura.value += 20

#endregion

#region colocar carvao
func _on_area_carvao_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		carvao = true
		print_debug(body)


func _on_area_carvao_body_exited(body: Node2D) -> void:
	carvao = false


func _on_area_carvao_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and carvao:
		if combustivel.value < 100:
			combustivel.value += 20
#endregion
