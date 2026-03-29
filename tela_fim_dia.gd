extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.fim_do_dia.connect(fim_do_dia)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	GameManager.comeco_do_dia.emit()
	hide()

func fim_do_dia():
	show()
