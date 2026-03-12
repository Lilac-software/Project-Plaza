extends Node3D

var test = Vector2(0,0)

func _unhandled_input(event: InputEvent) -> void:
	test = Input.get_vector("view_down","view_up","view_right","view_left",-1.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	rotation.x += test.x/15
	rotation.y += test.y/15
	rotation.x = clamp(rotation.x, PI/15.0, PI/2.1)
