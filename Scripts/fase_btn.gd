extends Button
@export var tranca = true
@export var nome_fase: String 
@export var nmr_fase: String 
@export var fase_bloqueio = 0
@onready var fase = $fase
@onready var bloqueio = $bloqueio
@onready var troca_btn = $troca_btn
var nmr_um = preload("res://Addons/Free/Menu/Levels/1.png")
var nmr_dois = preload("res://Addons/Free/Menu/Levels/2.png")
var nmr_tres = preload("res://Addons/Free/Menu/Levels/3.png")
var nmr_quatro = preload("res://Addons/Free/Menu/Levels/4.png")

func _ready():
	if Global.fase > fase_bloqueio:
		tranca = false
	if tranca:
		bloqueio.visible = true
	else:
		bloqueio.visible = false
	match nmr_fase:
		"1":
			fase.texture = nmr_um
		"2":
			fase.texture = nmr_dois
		"3":
			fase.texture = nmr_tres
		"4":
			fase.texture = nmr_quatro


func _on_pressed():
	if !tranca:
		get_tree().change_scene_to_file(nome_fase)

func _on_mouse_exited():
	if !tranca:
		troca_btn.play()

