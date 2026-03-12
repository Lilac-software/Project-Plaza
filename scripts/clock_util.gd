extends Label




func _process(delta: float) -> void:
	update()

func update() -> void:
	var date : String = Time.get_date_string_from_system()
	var time : String = Time.get_time_string_from_system()
	text = date +"\n"+ time 
	pass
