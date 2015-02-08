local claw = {
	name = "claw",
	rate = 10,
	delay = 0,
	n_delay = 0,
	delaymax = 3,
	rotation = 0,

	update = function (self, dt, heros)
		if love.keyboard.isDown('q') and self.delay <= 0 then
			self.delay = self.delaymax
		end

		if self.delay > 0 then
			self.delay = self.delay - self.rate * dt
		else

			if heros.orientation == 'up' then self.rotation = 0 end
			if heros.orientation == 'down' then self.rotation = 3.14 end
			if heros.orientation == 'left' then self.rotation = 3.14 * 1.5 end
			if heros.orientation == 'right' then self.rotation = 3.14 / 2 end

		end

		if self.n_delay > 0 and self.n_delay < self.delaymax then
			self.shader:send("max_white", self.n_delay / self.delaymax)
		else
			self.shader:send("max_white", 0)
		end

		self.n_delay = self.delaymax - self.delay
	end,

	image = love.graphics.newImage("img/claw.png"),
	effect = love.graphics.newImage("img/claw_effect.png"),
	shader = love.graphics.newShader([[
		extern Image eff;
		extern number max_white;

		vec4 effect( vec4 color, Image tex, vec2 tc, vec2 sc )
		{
			vec4 eff_color = Texel(eff,tc);
			vec4 tex_color = Texel(tex, tc);
			number white_level = (eff_color.r + eff_color.g + eff_color.b) / 3;

			if (white_level <= max_white && white_level >= max_white - 0.6)
				return tex_color * color;

			tex_color.a = 0;
			return tex_color;
		}
	]]),

	draw = function (self, heros)
		love.graphics.setColor(heros.color.number[heros.color.color])
		love.graphics.setShader(self.shader)
			love.graphics.draw(self.image, heros.x, heros.y, self.rotation - 0.5 + self.n_delay / 12, 3, 3, 50, 50)
		love.graphics.setShader()
		love.graphics.setColor(255, 255, 255)
	end
}

claw.shader:send('eff', claw.effect)

return claw
