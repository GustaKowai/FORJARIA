extends Node2D
@onready var timer: Timer = $Timer
@onready var marker_2d: Marker2D = $Marker2D
@onready var tesoura: Area2D = $Area2D
var tamanho_tesoura:int = 22
var vector_position:Vector2 = Vector2(1,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tesoura.position = marker_2d.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	tesoura.position+=vector_position*tamanho_tesoura


func _on_cima_pressed() -> void:
	if vector_position.y == 0 : vector_position = Vector2(0,-1) 
func _on_baixo_pressed() -> void:
	if vector_position.y == 0 : vector_position = Vector2(0,1) 
func _on_esquerda_pressed() -> void:
	if vector_position.x == 0: vector_position = Vector2(-1,0) 
func _on_direita_pressed() -> void:
	if vector_position.x == 0 : vector_position = Vector2(1,0) 
