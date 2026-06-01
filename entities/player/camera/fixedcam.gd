extends Camera3D

@onready var origin: Vector3 = position
@onready var player: Node3D = get_parent()
@onready var tracker: MeshInstance3D = $"../tracker"
var trackerpos: Vector3

func _ready() -> void:
	trackerpos = tracker.position

func _physics_process(delta: float) -> void:
	var currentpos:Vector3 = player.position
	tracker.position=lerp(tracker.position,currentpos, 0.5)
	var targetpos:Vector3 = lerp(trackerpos,player.position, 0.5)
	look_at_from_position(origin, tracker.position)
