local heros = {}

function heros:load(color)
	if color.color == nil then
		print("wrong color")
	else
		print("loading a new "..color.color.." heros")
	end

	self.color = color

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

	self.shader = love.graphics.newShader [[
		extern Image eff;
		extern number max_white;

		vec4 effect( vec4 color, Image tex, vec2 tc, vec2 sc )
		{
			vec4 eff_color = Texel(eff,tc);
			vec4 tex_color = Texel(tex, tc);
			number white_level = (eff_color.r + eff_color.g + eff_color.b)/3;

			if (white_level <= max_white && white_level >= max_white - 0.4)
				return eff_color * color;

			tex_color.a = 0;
			return tex_color;
		}
	]]
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

	self.delay = self.rotation_delay
	self.delay = self.rotation_delaymax - self.delay
	-- print(self.delay / self.rotation_delaymax)
	if self.delay > 0 and self.delay < self.rotation_delaymax then
		self.shader:send("max_white", self.delay / self.rotation_delaymax)
	else
		self.shader:send("max_white", 0)
	end
	self.shader:send("eff", love.graphics.newImage("img/01_effect.png"))
end

function heros:draw()
	-- love.graphics.circle("line", self.x, self.y, 42)
	-- love.graphics.scale(4, 4)

	love.graphics.draw(self.img, self.x, self.y, self.rotation, self.x_scale, self.y_scale, self.img:getWidth() / 2, self.img:getHeight() / 2)
	love.graphics.setColor(self.color.number[self.color.color])
	love.graphics.setShader(self.shader)
	love.graphics.draw(self.effect,
		self.x, self.y,
		0 + self.delay,
		1 * (self.delay / 6) + 0.1, 1 * (self.delay / 6) + 0.1,
		47, 47)
	love.graphics.draw(self.effect,
		self.x, self.y,
		3.14 + self.delay,
		1 * (self.delay / 6) + 0.1, 1 * (self.delay / 6) + 0.1,
		47, 47)
	love.graphics.setShader()
	love.graphics.setColor(255, 255, 255)
end

function heros:dump()
	love.graphics.print(inspect(self))
end

function heros:keypressed(key, unicode)
	print('pressed: ', key, unicode)
end

function heros:keyreleased(self, key, unicode)
	print('released: ', key, unicode)
end

return heros
