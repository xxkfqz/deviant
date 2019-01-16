function love.conf(t)
	-- t.version = '0.10.2'
	t.console = false
	t.externalstorage = true
	t.identity = 'deviant'

	t.window.title = 'Deviant'
	t.window.fullscreen = true
	t.window.vsync = true

	t.modules.audio = false
	t.modules.image = false
	t.modules.joystick = false
	t.modules.keyboard = false
	t.modules.math = false
	t.modules.mouse = false
	t.modules.physics = false
	t.modules.sound = false
	t.modules.system = false
	t.modules.touch = false
	t.modules.video = false
	t.modules.thread = false
end
