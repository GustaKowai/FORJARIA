extends Area2D
@export var carvao:PackedScene
@onready var marker_2d: Marker2D = $Marker2D
@onready var seta_maquina: Node2D = $Seta_maquina




func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#print_debug("cliquei no item")
		var ta_em_cima = get_overlapping_bodies()
		#print_debug(ta_em_cima)
		for ferreiro in ta_em_cima:
			#print_debug(ferreiro.is_in_group("jogador"))
			if ferreiro.is_in_group("jogador"):
				var carvao_scene = carvao.instantiate()
				carvao_scene.global_position = marker_2d.global_position
				get_parent().add_child(carvao_scene)
				


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		seta_maquina.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		seta_maquina.visible = false
