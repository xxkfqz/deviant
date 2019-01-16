player = {}

local lg = love.graphics

function player:init()
	self.size = winH / 9
	self.x = winW / 2 - self.size / 2
	self.y = winH / 2 - self.size / 2
	self.dir = math.random(0, 100) < 50
	self.speed = self.size * 5
end

function player:update(dt)
	local add = self.speed
	if not self.dir then
		add = -add
	end
	self.y = self.y + add * dt

	if self.y <= 0 or self.y + self.size >= winH then
		state = 2
	end
end

function player:draw()
	local color = 255 - alpha
	lg.setColor(color, color, color)
	lg.rectangle('fill', self.x, self.y, self.size, self.size)
end
