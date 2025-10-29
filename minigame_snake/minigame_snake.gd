extends Node2D
@onready var timer: Timer = $Timer
@onready var marker_2d: Marker2D = $Marker2D
@onready var tesoura: Area2D = $Area2D
@onready var sprite_tesoura: AnimatedSprite2D = $Area2D/Sprite2D
@onready var score_label: Label = %score_label
@onready var item_list: ItemList = $ItemList
@export var cabo:PackedScene
var tamanho_cabo:String
var tamanho_tesoura:int = 70
var vector_position:Vector2 = Vector2(1,0)
var pontuacao:float = 0

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	tesoura.position = marker_2d.position
	GameManager.mini_game_snake_end.connect(end_minigame)
	GameManager.mini_game_snake_score.connect(change_score)
	sprite_tesoura.speed_scale = 1/timer.wait_time
	GameManager.direcao_tesoura = "d"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	tesoura.position+=vector_position*tamanho_tesoura


func _on_cima_pressed() -> void:
	if vector_position.y == 0 :
		vector_position = Vector2(0,-1)
		sprite_tesoura.rotation_degrees = -90
		GameManager.direcao_tesoura = "c"
func _on_baixo_pressed() -> void:
	if vector_position.y == 0 : 
		vector_position = Vector2(0,1) 
		sprite_tesoura.rotation_degrees = 90
		GameManager.direcao_tesoura = "b"
func _on_esquerda_pressed() -> void:
	if vector_position.x == 0: 
		vector_position = Vector2(-1,0) 
		sprite_tesoura.rotation_degrees = 180
		GameManager.direcao_tesoura = "e"
func _on_direita_pressed() -> void:
	if vector_position.x == 0 :
		vector_position = Vector2(1,0) 
		sprite_tesoura.rotation_degrees = 0
		GameManager.direcao_tesoura = "d"

func end_minigame():
	timer.stop()
	sprite_tesoura.stop()
	if pontuacao > 0:
		gerar_item()
	GameManager.exit_minigame.emit()

func gerar_item():
	var item_gerado:Item = cabo.instantiate()
	item_gerado.qualidade = 100*pontuacao/GameManager.valor_do_couro
	item_gerado.name = "cabo"
	item_gerado.tamanho = tamanho_cabo
	item_gerado.pontuacao = item_gerado.qualidade*GameManager.multiplicador_de_qualidade
	GameManager.valor_do_couro = 0
	GerenciadorItens.Item_coletado.emit(0,item_gerado)

func change_score(pontos):
	pontuacao+=pontos
	score_label.text = str(pontuacao)


func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	match index:
		0:
			tamanho_cabo = "pequeno"
		1:
			tamanho_cabo = "médio"
		2:
			tamanho_cabo = "grande"
	timer.start()
	item_list.hide()
