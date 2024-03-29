@tool
extends MarginContainer

signal project_root_set(path : FilePath)

@onready var file_dialog: FileDialog = $FileDialog

var request_ps_path = "res://native/ps/f2.ps1"
var default_root = FilePath.from_string("C:\\liam\\assets")
var native_req
var root : String

func _ready() -> void:
	native_req = ProjectSettings.globalize_path(request_ps_path)
	set_project_root(default_root)
	
	
func _on_button_pressed() -> void:
	var output = []
	OS.execute("powershell.exe", ["-Command", native_req], output)
	root = output[0]
	root = root.left(-len("[Select this folder]") - 1)
	set_project_root(root)

func set_project_root(root):
	project_root_set.emit(root)

