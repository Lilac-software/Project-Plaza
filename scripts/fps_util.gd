extends Label

func _process(delta: float) -> void:
	update()

func update() -> void:
	text = str(Engine.get_frames_per_second()) + " FPS" 
	pass
