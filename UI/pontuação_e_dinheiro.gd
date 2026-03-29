extends Control
@onready var ouro_label: Label = $VBoxContainer/ouro/ouro_label
@onready var fama_label: Label = $VBoxContainer/fama/fama_label
@onready var fama_ganha: Label = $VBoxContainer/fama/fama_ganha

func _ready() -> void:
	GameManager.muda_ouro.connect(muda_ouro)
	GameManager.muda_fama.connect(muda_fama)
	
func muda_ouro(mudanca):
	ouro_label.text = str(GameManager.ouro)

func muda_fama(mudanca):
	fama_label.text = str(GameManager.fama)
	if mudanca > 0:
		fama_ganha.text = "+" + str(mudanca)
		fama_ganha.label_settings.font_color = Color(0, 1, 0)
		
	else:
		fama_ganha.text = str(mudanca)
		fama_ganha.label_settings.font_color = Color(1,0,0)
	var tween2 = create_tween()
	tween2.tween_property(fama_ganha,"modulate:a",1,1)
	tween2.tween_property(fama_ganha,"modulate:a",0,5)
