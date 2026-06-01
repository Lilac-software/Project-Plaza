extends Camera3D

@export var player: CharacterBody3D
var offset : Vector3
var defaultrotation: Vector3 = self.rotation_degrees


func _ready() -> void:
	offset = global_position - player.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position = lerp(global_position,player.global_position+offset,0.1)
	if Input.is_action_just_pressed("zoom_in") and fov > 20:
		#fov -= 10
		var zoom_tween = create_tween()
		zoom_tween.tween_property(self,"fov",fov-10,0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		#fov = lerp(fov, fov-10, 0.1)
	if Input.is_action_just_pressed("zoom_out") and fov < 60:
		#fov += 10
		var zoom_tween = create_tween()
		zoom_tween.tween_property(self,"fov",fov+10,0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

#func _input(event: InputEvent) -> void: #this was meant to be a rotate camera feature
	#var test: Vector2 = Vector2(Input.get_joy_axis(0,JOY_AXIS_RIGHT_Y), Input.get_joy_axis(0,JOY_AXIS_RIGHT_X))
	#print(test)
	#var camerapan: Vector3 = Vector3(-test.x*10, -test.y*10, 0)
	#rotation_degrees.x = lerp_angle(rotation_degrees.x,defaultrotation.x+camerapan.x,0.1)
	##rotation_degrees = lerp(rotation_degrees, defaultrotation + camerapan, 0.1)
