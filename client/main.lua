heros = {}

inspect = require 'inspect'

function heros:load()
	self.img = love.graphics.newImage("img/white_square.jpg")
	self.effect = love.graphics.newImage("img/01.png")

	self.x = 50
	self.y = 50
	self.width = 42
	self.height = 42
	self.x_scale = self.width / self.img:getWidth()
	self.y_scale = self.height / self.img:getHeight()
	self.rotation = 0
	self.rotation_rate = 10
	self.rotation_delay = 0
	self.rotation_delaymax = 7.85
	print(inspect(self))


	self.pixelcode = love.graphics.newShader [[
		extern Image eff;
		extern number max_white;

		vec4 effect( vec4 color, Image tex, vec2 tc, vec2 sc )
		{
			vec4 eff_color = Texel(eff,tc);
			vec4 tex_color = Texel(tex, tc);
			number white_level = (eff_color.r + eff_color.g + eff_color.b)/3;

			if (white_level <= max_white && white_level >= max_white - 0.4)
				return tex_color;

			tex_color.a = 0;
			return tex_color;
		}
	]]

	print(inspect(_G))
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
		self.rotation_delay = self.rotation_delaymax
	end

	if self.rotation_delay > 0 then
		self.rotation = self.rotation + self.rotation_delay * dt
		self.rotation_delay = self.rotation_delay - self.rotation_rate * dt
	else
		self.rotation = 0
	end

	local delay = self.rotation_delay
	delay = self.rotation_delaymax - delay
	-- print(delay / self.rotation_delaymax)
	if delay > 0 and delay < self.rotation_delaymax then
		self.pixelcode:send("max_white", delay / self.rotation_delaymax)
	else
		self.pixelcode:send("max_white", 0)
	end
	self.pixelcode:send("eff", love.graphics.newImage("img/01_effect.png"))
end

function heros:draw()
	-- love.graphics.circle("line", self.x, self.y, 42)
	-- love.graphics.scale(4, 4)

	love.graphics.draw(self.img, self.x, self.y, self.rotation, self.x_scale, self.y_scale, self.img:getWidth() / 2, self.img:getHeight() / 2)
	love.graphics.setShader(self.pixelcode)
	love.graphics.draw(self.effect, self.x, self.y, 0, 1, 1, 47, 47)
	love.graphics.setShader()
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
