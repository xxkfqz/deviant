local lg = love.graphics
local font = lg.getFont()
local fontHeight = font:getHeight()

function printOnCenter(str)
	local width = font:getWidth(str)
	local _, wrap = font:getWrap(str, winW)
	local lines = #wrap

	lg.printf(str, 0, (winH - fontHeight * lines) / 2, winW, 'center')
end

function insideBox(x,y, x1,y1,w1,h1)
	return x >= x1 and
	x <= x1 + w1 and
	y >= y1 and
	y <= y1 + h1
end
