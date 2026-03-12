extends CharacterBody3D

@onready var character: Node3D = $CharacterSkin
@onready var cam_pivot = $CameraPivot
@onready var active_cam = get_viewport().get_camera_3d()
const BASE_SPEED: float = 2.5
var facing: Vector2
var camera_input = Vector2(0,0)

func _physics_process(delta: float) -> void:
	cam_pivot.rotation.x += -camera_input.x/15
	cam_pivot.rotation.y += camera_input.y/15
	cam_pivot.rotation.x = clamp(cam_pivot.rotation.x, -PI/30.0, PI/2.1)
	var speed_modifier = 0
	if Input.is_action_pressed("run_button"):
		speed_modifier = 2
	var speed = BASE_SPEED + speed_modifier
	var direction:Vector2 = Input.get_vector("movement_up","movement_down","movement_left","movement_right").normalized()
	#var fb_movement = cam_pivot.global_basis.z * -direction.x
	#var lr_movement = cam_pivot.global_basis.x * -direction.y
	#var movement = fb_movement + lr_movement
	#movement.y = 0
	var fb_movement = active_cam.global_basis.z * direction.x
	var lr_movement = active_cam.global_basis.x * direction.y
	#var movement:Vector3 = Vector3(direction.y,0,direction.x)
	var movement:Vector3 = fb_movement + lr_movement
	movement.y = 0
	movement = movement.normalized()
	if direction != Vector2(0,0):
		#character.get_node("AnimationPlayer").play("Walk")
		##
		#if Input.is_action_pressed("run_button"):
			#character.get_node("AnimationPlayer").speed_scale = 1.5
		facing = lerp(facing,Vector2(movement.x, movement.z),0.1)
		pass
	else : character.get_node("AnimationPlayer").play("Idle")
	
	velocity = movement * speed # Vector3(direction.y*speed,0,direction.x*speed)
	$CharacterSkin.rotation.y = -facing.angle() + PI/2
	$MeshInstance3D2.rotation.y = -facing.angle() + PI/2
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	camera_input = Input.get_vector("view_down","view_up","view_right","view_left",-1.0)
