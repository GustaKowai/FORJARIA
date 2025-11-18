extends Item
@export var pontuacao:float
@export var tamanho:String
@export var sprites_tamanhos:Array[Texture2D]
@export var dicionario:Dictionary[String,int]

func _ready() -> void:
	sprite_2d.texture = sprites_tamanhos[dicionario[tamanho]]
	print_debug("cabo pronto")
	super()
