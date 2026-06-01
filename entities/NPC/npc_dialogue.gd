extends Area3D
var playerinrange = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") and playerinrange:
		use_dialogue()


func use_dialogue():
	var dialogue_box = $"../DialogueBox"
	if dialogue_box:
		dialogue_box.start()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(playerinrange)
	pass


func _on_body_entered(body: Node3D) -> void:
	playerinrange = true
	pass # Replace with function body.

func _on_body_exited(body: Node3D) -> void:
	playerinrange = false
	pass # Replace with function body.
