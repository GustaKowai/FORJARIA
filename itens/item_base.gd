extends Node2D

@export var item_name: String = "Item_Base"
@export var qualidade: float = 50.0 

func _collect():
	print("Item base coletado")
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("jogador"):
		_collect()
