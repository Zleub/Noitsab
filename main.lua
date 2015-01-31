heros = {}

inspect = require 'inspect'

function heros:load()
	self.img = love.graphics.newImage("img/white_square.jpg")

	self.x = 50
	self.y = 50
	self.width = 42
	self.height = 42
	inspect(self.img)
	self.x_scale = self.width / self.img:getWidth()
	self.y_scale = self.height / self.img:getHeight()
	self.rotation = 0
	self.rotation_rate = 10
	self.rotation_delay = 0
	print(inspect(self))
end

function heros:update(dt)
	if love.keyboard.isDown('up') then
		self.y = self.y - 1
	end
	if love.keyboard.isDown('down') then
		self.y = self.y + 1
	end
	if love.keyboard.isDown('right') then
		self.x = self.x + 1
	end
	if love.keyboard.isDown('left') then
		self.x = self.x - 1
	end

	if love.keyboard.isDown(' ') and self.rotation_delay <= 0 then
		self.rotation_delay = 7.85
	end

	if self.rotation_delay > 0 then
		self.rotation = self.rotation + self.rotation_rate * dt
		self.rotation_delay = self.rotation_delay - self.rotation_rate * dt
	else
		self.rotation = 0
	end
end

function heros:draw()
	love.graphics.draw(self.img, self.x, self.y, self.rotation, self.x_scale, self.y_scale, self.img:getWidth() / 2, self.img:getHeight() / 2)
end

function heros:dump()
	love.graphics.print(inspect(self))
end

function heros:keypressed(key, unicode)
	print('pressed: ', key, unicode)
end

function heros:keyreleased(key, unicode)
	print('released: ', key, unicode)
end

function love.load()
	heros:load()
end

function love.update(dt)
	heros:update(dt)
end

function love.draw()
	heros:dump()
	heros:draw()
end

function love.keypressed(key, unicode)
	heros:keypressed(key, unicode)
end

function love.keyreleased(key, unicode)
	heros:keyreleased(key, unicode)
end
