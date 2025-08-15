extends Node2D

var fruta_selecionada: String = ""

@onready var fala_root: Node2D = $Fala
@onready var fala_label: Label = $Fala/TextFala
@onready var terra_sprite: Sprite2D = $Terra/Sprite
@onready var botao_maca: TextureButton = $BotaoMaca
@onready var terra_area: Area2D = $Terra

func _ready() -> void:
    # conecta sinais por código (não precisa usar o editor)
    botao_maca.pressed.connect(Callable(self, "_on_BotaoMaca_pressed"))
    terra_area.input_event.connect(Callable(self, "_on_Terra_input_event"))
    # fala inicial (podemos trocar pelo pack de falas que combinamos)
    mostrar_fala("Oi! Sou o Colega. Vou te ajudar a evoluir sua fazendinha!!! Toque no botão da maçã e depois na terra!")

func mostrar_fala(texto: String, dur: float = 3.0) -> void:
    fala_label.text = texto
    fala_root.visible = true
    await get_tree().create_timer(dur).timeout
    fala_root.visible = false

func _on_BotaoMaca_pressed() -> void:
    fruta_selecionada = "Maca"
    mostrar_fala("Maçã selecionada! Agora toque na terra.")

func _on_Terra_input_event(viewport, event, shape_idx) -> void:
    if fruta_selecionada != "Maca":
        return
    if (event is InputEventMouseButton and event.pressed) \
    or (event is InputEventScreenTouch and event.pressed):
        terra_sprite.texture = load("res://assets/Treemaca.png")
        mostrar_fala("Regou e cresceu! 🍎")
        fruta_selecionada = ""
