extends Node2D
class_name Bloquinho
@export var pontos:int
@export var cor:Color
@onready var sprite_2d: Sprite2D = $Area2D/Sprite2D
var cortado:bool = false

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	cortar()
	#print_debug("fui atingido")

func cortar():
	if sprite_2d.modulate == cor:
		print_debug("morreu")
		GameManager.mini_game_snake.emit()
	else:
		sprite_2d.modulate = cor
		cortado = true
		GameManager.mini_game_snake_score.emit(pontos)
