extends TextureButton


@export var url : String


func _on_pressed():
    OS.shell_open(url)
