extends Item

var temperatura:float = 100
@export var minerio_frio:Texture2D


func _process(delta: float) -> void:
	if temperatura > 0:
		temperatura -= delta
	else:
		item_name = "minerio"
		sprite_2d.texture = minerio_frio
