extends Node2D
@onready var sprite_2d: Sprite2D = $Area2D/Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	sprite_2d.modulate = Color(255,0,0)
	print_debug("fui atingido")
