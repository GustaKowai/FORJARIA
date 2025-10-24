extends Node2D
class_name Bloquinho
@export var pontos:int
@export var cor:Color
@onready var sprite_2d: Sprite2D = $Area2D/Sprite2D
var cortado:bool = false
var posicao_de_entrada:String

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("tesoura"):
		posicao_de_entrada = GameManager.direcao_tesoura
		cortar()
	#print_debug("fui atingido")

func cortar():
	if cortado:
		print_debug("morreu")
		GameManager.mini_game_snake_end.emit()
	else:
		#sprite_2d.modulate = cor
		#cortar_sprite()
		cortado = true
		GameManager.mini_game_snake_score.emit(pontos)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("tesoura"):
		cortar_sprite(posicao_de_entrada, GameManager.direcao_tesoura)
	
func cortar_sprite(entrada,saida):
	var sprite_corte = Sprite2D.new()
	sprite_corte.texture = sprite_2d.texture
	sprite_corte.hframes = 6
	sprite_corte.vframes = 6
	#if posicao_de_entrada == "d" and GameManager.direcao_tesoura == "d" or posicao_de_entrada == "e" and GameManager.direcao_tesoura == "e":
	print_debug(entrada,saida)
	match [entrada,saida]:
		["d","d"]:
			sprite_corte.frame = 13
		["e","e"]:
			sprite_corte.frame = 13
		["c","c"]:
			sprite_corte.frame = 19
		["b","b"]:
			sprite_corte.frame = 19
		["d","c"]:
			sprite_corte.frame = 21
		["d","b"]:
			sprite_corte.frame = 15
		["e","c"]:
			sprite_corte.frame = 20
		["e","b"]:
			sprite_corte.frame = 14
		["c","d"]:
			sprite_corte.frame = 14
		["c","e"]:
			sprite_corte.frame = 15
		["b","d"]:
			sprite_corte.frame = 20
		["b","e"]:
			sprite_corte.frame = 21
		
		
	add_child(sprite_corte)
	
