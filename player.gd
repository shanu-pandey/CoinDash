extends Area2D

signal pickup
signal hurt

@export var speed = 350
var velocity = Vector2.ZERO
var screenSize = Vector2(480,720)
var size = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	print("this is a start") # Replace with function body.

func start():
	set_process(true)
	position = screenSize/2
	$AnimatedSprite2D.animation = "idle"
	var frame_texture = $AnimatedSprite2D.sprite_frames.get_frame_texture($AnimatedSprite2D.animation, $AnimatedSprite2D.frame)
	size = frame_texture.get_size()	

func die():
	$AnimatedSprite2D.animation = "hurt"
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Input.get_vector("ui_left", "ui_right","ui_up", "ui_down")	
	position += velocity * speed * delta
	position.x = clamp(position.x, size.x/2, screenSize.x - size.x/2)
	position.y = clamp(position.y, size.y/2, screenSize.y - size.y/2)
	
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
		
	if velocity.x !=0:
		$AnimatedSprite2D.flip_h = velocity.x <0


func _on_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit()
	if area.is_in_group("obstacles"):
		hurt.emit()
		die()
		


