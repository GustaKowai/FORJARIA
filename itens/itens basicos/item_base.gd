extends Node2D
class_name Item

#@onready var dados_item: DadosItens = $dados_item

@onready var area_2d: Area2D = $Area2D
@export var sprite:Texture2D
@export var item_name: String# = "Item_Base"
@export var qualidade: float# = 50.0 
@onready var sprite_2d: Sprite2D = $Area2D/Sprite2D
@onready var marker_2d: Marker2D = $Marker2D
@onready var seta_item: Node2D = $Seta_item

var _self_scene:PackedScene
var coletado:bool = false

func _ready() -> void:
	print_debug(sprite_2d)
	#item_name = dados_item.item_name
	#qualidade = dados_item.qualidade
	_self_scene = PackedScene.new()
	_self_scene.pack(self)
	sprite = sprite_2d.texture

	pass
	
func _collect():
	var slot:int
	if GerenciadorItens.inventario[0] == null:
		if GerenciadorItens.inventario[0] == null:
			GerenciadorItens.Item_coletado.emit(0,self.duplicate())
			print_debug(item_name+" coletado no slot 0")
			coletado = true
			queue_free()
			return
	else:
		print_debug("inventario cheio")
	if GerenciadorItens.inventario[2] != null:
		if GerenciadorItens.inventario[2].item_name == "mao de mao" and GerenciadorItens.inventario[1]==null and !coletado:
			GerenciadorItens.Item_coletado.emit(1,self.duplicate())
			print_debug(item_name+" coletado no slot 1")
			queue_free()
			return
	else:
		print_debug("mão secundaria indisponivel")
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		#modulate = Color(1.5,1.5,1.5)
		seta_item.visible = true
		#print_debug("Da pra pegar")
		#_collect()
		pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		#modulate = Color(1,1,1)
		#print_debug("Saiu do range")
		seta_item.visible = false
	pass # Replace with function body.


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#print_debug("cliquei no item")
		var ta_em_cima = area_2d.get_overlapping_bodies()
		#print_debug(ta_em_cima)
		for ferreiro in ta_em_cima:
			#print_debug(ferreiro.is_in_group("jogador"))
			if ferreiro.is_in_group("jogador"):
				_collect()
