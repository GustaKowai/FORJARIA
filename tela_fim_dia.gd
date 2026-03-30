extends Control

@onready var ouro_n: Label = %ouro_n
@onready var fama_n: Label = %fama_n
@onready var acertos_n: Label = %acertos_n
@onready var erros_n: Label = %erros_n
@onready var perdidos_n: Label = %perdidos_n
@onready var bg_final: AnimatedSprite2D = $bg_final
@onready var info_container: VBoxContainer = $Info_container



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.fim_do_dia.connect(fim_do_dia)
	info_container.modulate.a = 0
	ouro_n.modulate.a = 0
	fama_n.modulate.a = 0
	acertos_n.modulate.a = 0
	erros_n.modulate.a = 0
	perdidos_n.modulate.a = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	GameManager.comeco_do_dia.emit()
	GameManager.pedidos_corretos = 0
	GameManager.pedidos_errados = 0
	GameManager.pedidos_incompletos = 0
	info_container.modulate.a = 0
	ouro_n.modulate.a = 0
	fama_n.modulate.a = 0
	acertos_n.modulate.a = 0
	erros_n.modulate.a = 0
	perdidos_n.modulate.a = 0
	hide()

func fim_do_dia():
	
	show()
	bg_final.play()


func _on_bg_final_animation_finished() -> void:
	ouro_n.text = str(GameManager.ouro)
	fama_n.text = str(GameManager.fama)
	acertos_n.text = str(GameManager.pedidos_corretos)
	erros_n.text = str(GameManager.pedidos_errados)
	perdidos_n.text = str(GameManager.pedidos_incompletos)
	var tween = create_tween()
	tween.tween_property(info_container, "modulate:a", 1, 2)
	tween.tween_property(ouro_n, "modulate:a", 1, 0.5)
	tween.tween_property(fama_n, "modulate:a", 1, 0.5)
	tween.tween_property(acertos_n, "modulate:a", 1, 0.5)
	tween.tween_property(erros_n, "modulate:a", 1, 0.5)
	tween.tween_property(perdidos_n, "modulate:a", 1, 0.5)
	
