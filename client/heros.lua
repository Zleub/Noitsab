socket = require 'socket'
protocol = require 'UDP'

local heros = {}

function heros:load(color)
	if color.color then
		print("loading a new "..color.color.." heros")
	end

	self.udp = socket.udp()
	self.udp:setpeername(arg[2], arg[3])

	self.color = color
	self.draw_color = {200, 200, 200}

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
	self.id = self.udp:receive()
	if self.id == nil then
		print('no server, exiting ...')
		self.id = -1
		love.event.quit()
	end

	self.udp:settimeout(0)
end

function heros:move(direction)
	-- print(direction)
	local tmp
	if direction == 'up' then
		tmp = string.format("%d %s 0, -1", self.id, protocol.msg.position)
	elseif direction == 'down' then
		tmp = string.format("%d %s 0, 1", self.id, protocol.msg.position)
	elseif direction == 'left' then
		tmp = string.format("%d %s -1, 0", self.id, protocol.msg.position)
	elseif direction == 'right' then
		tmp = string.format("%d %s 1, 0", self.id, protocol.msg.position)
	end
	self.udp:send(tmp)
	if self.udp:receive() == 'ko' then
		self.draw_color = {200, 0, 0}
	else
		self.draw_color = {200, 200, 200}
	end
end

function heros:update(dt)
	if love.keyboard.isDown('up') then
		self:move('up')
		-- self.y = self.y - dt * self.rate
		-- self.orientation = 'up'
	end
	if love.keyboard.isDown('down') then
		self:move('down')
		-- self.y = self.y + dt * self.rate
		-- self.orientation = 'down'
	end
	if love.keyboard.isDown('right') then
		self:move('right')
		-- self.x = self.x + dt * self.rate
		-- self.orientation = 'right'
	end
	if love.keyboard.isDown('left') then
		self:move('left')
		-- self.x = self.x - dt * self.rate
		-- self.orientation = 'left'
	end

	self.color:update(dt, self)
end

function heros:draw()
	love.graphics.setColor(self.draw_color)
	love.graphics.draw(self.img, self.x, self.y, self.rotation, self.x_scale, self.y_scale, self.img:getWidth() / 2, self.img:getHeight() / 2)
	love.graphics.setColor(255, 255, 255)

	self.color:draw(self)
end

function heros:dump()
	love.graphics.print(inspect(self))
end

function heros:die()
	local tmp = string.format("%d %s 0", self.id, protocol.msg.quit)
	self.udp:send(tmp)
end

-- function heros:keypressed(key, unicode)
-- 	print('pressed: ', key, unicode)
-- end

-- function heros:keyreleased(self, key, unicode)
-- 	print('released: ', key, unicode)
-- end

return heros
