socket = require 'socket'
protocol = require 'UDP'

local heros = {}

function heros:load(color)
	if color.color then
		print("loading a new "..color.color.." heros")
	end

	self.udp = socket.udp()
	self.udp:settimeout(0)
	self.udp:setpeername(arg[2], arg[3])

	self.color = color

	self.img = love.graphics.newImage("img/white_square.jpg")

	self.x = love.window.getWidth() / 2
	self.y = love.window.getHeight() / 2
	self.width = 42
	self.height = 42
	self.x_scale = self.width / self.img:getWidth()
	self.y_scale = self.height / self.img:getHeight()

	self.rate = 500
	self.rotation = 0
	self.orientation = 'up'

	self.udp:send(protocol.magic)
end

function heros:update(dt)
	if love.keyboard.isDown('up') then
		self.y = self.y - dt * self.rate
		self.orientation = 'up'
	end
	if love.keyboard.isDown('down') then
		self.y = self.y + dt * self.rate
		self.orientation = 'down'
	end
	if love.keyboard.isDown('right') then
		self.x = self.x + dt * self.rate
		self.orientation = 'right'
	end
	if love.keyboard.isDown('left') then
		self.x = self.x - dt * self.rate
		self.orientation = 'left'
	end

	self.color:update(dt, self)
end

function heros:draw()
	love.graphics.draw(self.img, self.x, self.y, self.rotation, self.x_scale, self.y_scale, self.img:getWidth() / 2, self.img:getHeight() / 2)
	self.color:draw(self)
end

function heros:dump()
	love.graphics.print(inspect(self))
end

function heros:die()
	self.udp:send('die')
end

-- function heros:keypressed(key, unicode)
-- 	print('pressed: ', key, unicode)
-- end

-- function heros:keyreleased(self, key, unicode)
-- 	print('released: ', key, unicode)
-- end

return heros
