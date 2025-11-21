extends Control
#se quiser animar esta tela, ep 27
var tranca = true
@onready var bloqueio = $MarginContainer/HBoxContainer/VBoxContainer/Button_continue/bloqueio
@onready var button_start = $MarginContainer/HBoxContainer/VBoxContainer/Button_start
@onready var troca_btn = $troca_btn

func _process(_delta):
	Global.moeda = 0
	Global.vida_jogador = 3
	Global.abates = 0


func _on_button_start_pressed():
	Global.fase = 0
	get_tree().change_scene_to_file("res://Scenes/seletor_fases.tscn")

func _on_button_quit_pressed():
	get_tree().quit()

func _on_button_continue_pressed():
	if !tranca:
		get_tree().change_scene_to_file("res://Scenes/seletor_fases.tscn")
	
	
func _ready():
	button_start.grab_focus()
	if Global.fase > 0:
		tranca = false
	if tranca:
		bloqueio.visible = true
	else:
		bloqueio.visible = false


func _on_button_start_focus_exited():
	troca_btn.play()

func _on_button_quit_focus_exited():
	troca_btn.play()
	
func _on_button_continue_focus_exited():
	if !tranca:
		troca_btn.play()


func _on_button_start_mouse_exited():
	troca_btn.play()

func _on_button_quit_mouse_exited():
	troca_btn.play()

func _on_button_continue_mouse_exited():
	if !tranca:
		troca_btn.play()


