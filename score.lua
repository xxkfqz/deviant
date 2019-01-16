score = {}

local lg = love.graphics
local lfs = love.filesystem
local fileName = 'totallyNotAVirus'

function score:init()
	score.count = 0
	self.high = lfs.read(fileName)
	self.high = tonumber(self.high)
	if not self.high then
		lfs.write(fileName, 0)
		self.high = 0
	end
	self:reset()
end

function score:reset()
	if self.high < self.count then
		self.high = self.count
	end
	self.count = 0
end

function score:save()
	if self.count > (self.high or 0) then
		print('saved!')
		lfs.write(fileName, self.count)
	end
end

function score:inc()
	self.count = self.count + 1
end

function score:drawCurrent()
	lg.setColor(0, 0, 0)
	lg.printf(self.count, 0, 0, winW, 'right')
end

function love.quit()
	lfs.write(fileName, score.high)
end
