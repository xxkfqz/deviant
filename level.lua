level = {}

local lg = love.graphics
local rand = math.random

local maxStack = 5
local universalOffset = 20
local generationTimer = 0
local maxTimer = 2
local px, py, ps = player.x, nil, player.size
local colomnSpeed = ps * 5
-- For 'rand'
local spaceHeightMin = ps * 2
local spaceHeightMax = ps * 3
local spaceYMax = winH - universalOffset
local widthMin = ps / 3
local widthMax = ps / 2

function level:init()
	self.stack = {}
	generationTimer = maxTimer
end

function level:update(dt)
	py = player.y

	if #self.stack < maxStack and generationTimer >= maxTimer then
		local new = {}

		new.spaceHeight = rand(spaceHeightMin, spaceHeightMax)
		new.spaceY = rand(universalOffset, spaceYMax - new.spaceHeight)
		new.width = rand(widthMin, widthMax)
		new.x = -new.width - 10

		table.insert(self.stack, new)
		generationTimer = 0
	end

	for _, c in ipairs(self.stack) do
		c.x = c.x + colomnSpeed * dt

		if
			-- LT
			insideBox(px, py, c.x, 0, c.width, c.spaceY) or
			-- RT
			insideBox(px + ps, py, c.x, 0, c.width, c.spaceY) or
			-- LB
			insideBox(px, py + ps, c.x, c.spaceY + c.spaceHeight, c.width, winW - c.spaceY + 1) or
			-- RB
			insideBox(px + ps, py + ps, c.x, c.spaceY + c.spaceHeight, c.width, c.spaceY) or

			px < c.x and
			px + ps > c.x + c.width and
			-- Top
			((py < c.spaceY) or
			-- Bot
			(py + ps > c.spaceY + c.spaceHeight))
		then
			state = 2
		end

		if c.x > px + ps and not c.score then
			score:inc()
			c.score = 1
		end

		if c.x > winW then
			table.remove(self.stack, 1)
		end
	end
	generationTimer = generationTimer + dt
end

function level:draw()
	local color = 255 - alpha
	for i = 1, #self.stack do
		local c = self.stack[i]

		lg.setColor(color, color, color)
		lg.rectangle('fill', c.x, -1, c.width, winW + 1)
		lg.setColor(255, 255, 255)
		lg.rectangle('fill', c.x, c.spaceY, c.width, c.spaceHeight)
	end
end
