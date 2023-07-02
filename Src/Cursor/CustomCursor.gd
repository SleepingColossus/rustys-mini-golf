extends Node


# Load the custom images for the mouse cursor.
var arrow = load("res://Cursor/CursorArrow.png")
var beam = load("res://Cursor/CursorBeam.png")


func _ready():
    # Changes only the arrow shape of the cursor.
    # This is similar to changing it in the project settings.
    Input.set_custom_mouse_cursor(arrow)


func _process(_delta):
    if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
        Input.set_custom_mouse_cursor(beam, Input.CURSOR_IBEAM)
