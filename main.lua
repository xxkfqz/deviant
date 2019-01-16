local lg = love.graphics
local alphaSpeed = 500

function love.load()
	math.randomseed(os.clock())
	math.random(); math.random(); math.random()

	winW, winH = lg.getDimensions()
	font = lg.newFont('century_gothic.ttf', math.floor(winH / 8))
	lg.setFont(font)

	require 'common'
	require 'player'
	player:init()
	require 'level'
	level:init()

	lg.setBackgroundColor(255, 255, 255)

	require 'score'
	score:init()

	--[[
		0 -> intro
		1 -> game
		2 -> game over
	]]
	state = 0
	alpha = 0
	score.high = score.high or 0
end

function love.update(dt)
	if state == 1 then
		player:update(dt)
		level:update(dt)
	elseif state == 0 then
		if alpha <= 255 then
			alpha = alpha + alphaSpeed * dt
		end
	elseif state == 2 then
		if not scoreSaved then
			score:save()
			scoreSaved = true
		end

		if alpha >= 0 then
			alpha = alpha - alphaSpeed * dt
		end
	end
end

function love.draw()
	if state == 1 then
		level:draw()
		player:draw()
		score:drawCurrent()
	elseif state == 0 then
		lg.setColor(0, 0, 0, alpha)
		printOnCenter('Deviant\nHigh score: ' .. score.high .. '\n(tap to start)')
	elseif state == 2 then
		if alpha > 0 then
			level:draw()
			player:draw()
		end

		lg.setColor(0, 0, 0, 255 - alpha)
		printOnCenter('Game over\n\nScore: ' .. score.count .. '\nHigh score: ' .. score.high .. '\n\nTap to restart')
	end
end

function love.mousepressed(x, y, button, istouch)
	if state == 1 then
		player.dir = not player.dir
	elseif state == 2 and alpha <= 0 then
		player:init()
		level:init()
		score:reset()
		state = 1
		alpha = 255
		scoreSaved = false
	elseif state == 2 then
		alpha = 0
	elseif state == 0 and alpha >= 255 then
		state = 1
	end
end
