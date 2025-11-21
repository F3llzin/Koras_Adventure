extends CanvasLayer
@onready var troca_btn = $troca_btn
@onready var button_voltar = $menu/Button_voltar


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true
		button_voltar.grab_focus()

func _on_button_voltar_pressed():
	get_tree().paused = false
	visible = false


func _on_button_inicio_pressed():
	get_tree().paused = false
	visible = false
	get_tree().change_scene_to_file("res://Scenes/Telainicio.tscn")


func _on_button_sair_pressed():
	get_tree().quit()


func _on_button_voltar_focus_exited():
	troca_btn.play()


func _on_button_voltar_mouse_exited():
	troca_btn.play()


func _on_button_inicio_focus_exited():
	troca_btn.play()


func _on_button_inicio_mouse_exited():
	troca_btn.play()


func _on_button_sair_focus_exited():
	troca_btn.play()


func _on_button_sair_mouse_exited():
	troca_btn.play()
