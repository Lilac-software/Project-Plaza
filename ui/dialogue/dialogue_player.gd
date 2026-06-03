extends CanvasLayer

@export_file("*.json") var dialogue_file# = preload("res://dialogue/testdialogue.json")

var dialogue = []
var character_name = []
var dialogue_id:int = 0
var is_active:bool = false
var is_ready:bool = true

func _ready() -> void:
	$NinePatchRect.hide()
	#start()
	pass

func start():
	#if is_active:
		#return
	is_active = true
	$NinePatchRect.show()
	visible = true
	dialogue = load_dialogue()
	set_dialogue()
	print("DIALOG STARTED")

func load_dialogue():
	var file = FileAccess.open("res://dialogue/testdialogue.json",FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func _input(event: InputEvent) -> void:
	if !is_active:
		return
	if Input.is_action_just_pressed("ui_accept"):
		next_line()

func next_line():
	if dialogue_id <= 1:
		dialogue_id += 1
		set_dialogue()
	else: end_dialogue()

func set_dialogue():
	$NinePatchRect/Panel2/NameText.text = dialogue[dialogue_id]['name']
	$NinePatchRect/DialogueText.text = dialogue[dialogue_id]['text']

func end_dialogue() -> void:
	hide()
	#self.queue_free() 
	$NinePatchRect.hide()
	await get_tree().create_timer(0.1).timeout
	is_active = false
	dialogue_id = 0
	pass

func _on_timer_timeout() -> void:
	is_active = false
	dialogue_id = 0
	pass


func _process(delta: float) -> void:
	print(str(is_active)+" "+str(dialogue_id)+" visible:"+str(visible))
	pass
