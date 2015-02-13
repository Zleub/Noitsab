inspect = require 'inspect'

FPS = {}

Scale = 21

function FPS:new(delay)
	self.width = love.window.getWidth()
	self.height = love.window.getHeight()
	self.delay = delay
	self.list = {}

	for i = 1, self.width / 3, 1 do
		self.list[i] = 0
	end

	self.update = function (self, dt)
		self.delay = self.delay - dt
		if self.delay < 0 then
			table.insert(self.list, love.timer.getFPS())
			if #self.list - 1 > self.width / 3 then
				table.remove(self.list, 1)
			end
			self.delay = delay
		end
	end

	self.draw = function (self)
		love.graphics.setColor(255, 255, 255, 100)
		for k,v in pairs(self.list) do
			if v < 30 then love.graphics.setColor(255, 0, 0, 100) end
			love.graphics.rectangle('fill',
				self.width - (k * 3),
				self.height - v,
				3, v)
			if v < 30 then love.graphics.setColor(255, 255, 255, 100) end
		end
		love.graphics.setColor(255, 255, 255, 255)
	end
end

function love.load()
	width = love.window.getWidth()
	height = love.window.getHeight()

	FPS:new(0.1)
	heros = require 'heros'
	heros:load( dofile(arg[1]..'/color.lua'):load('red') )
	map = require 'map'
	map.draw = function (self)
		love.graphics.setColor(0, 150, 0)
		for k,v in ipairs(self.list) do
			if v.shape == 'circle' then
				love.graphics.circle('fill', v.x * Scale - heros.x_map + width / 2, v.y * Scale - heros.y_map + height / 2, v.radius * Scale)
			elseif v.shape == 'rectangle' then
				love.graphics.rectangle('fill', v.x * Scale - heros.x_map + width / 2, v.y * Scale - heros.y_map + height / 2, v.width * Scale, v.height * Scale)
			end
		end
		love.graphics.setColor(255, 255, 255)
	end
end

function love.update(dt)
	heros:update(dt)
	FPS:update(dt)
end

function love.draw()
	map:draw()
	heros:dump()
	heros:draw()
	FPS:draw()
end

function love.quit()
	heros:die()
	return false
end

-- function love.keypressed(key, unicode)
-- 	heros:keypressed(key, unicode)
-- end

-- function love.keyreleased(key, unicode)
-- 	heros:keyreleased(key, unicode)
-- end
