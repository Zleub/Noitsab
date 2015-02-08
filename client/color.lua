local color = {}

color.enum = {
	"black",
	"red",
	"green",
	"blue",
	"white"
}

color.number = {
	black = {0, 0, 0},
	red = {200, 0, 0},
	green = {0, 200, 0},
	blue = {0, 0, 200},
	white = {200, 200, 200}
}

color.set = {
	black = {'whirlwind', 'claw'},
	red = {'whirlwind', 'claw'},
	green = {'whirlwind', 'claw'},
	blue = {'whirlwind', 'claw'},
	white = {'whirlwind', 'claw'}
}

function color:load(enum)
	for k,v in pairs(self.enum) do
		if v == enum then
			self.color = enum
		end
	end

	if self.color == nil then
		print('Trying to load undefined color: '.. enum)
		love.event.quit()
	else
		self.attacks = {}
		for key, val in pairs(self.set[self.color]) do
			self.attacks[val] = dofile(arg[1].."/attack.lua"):load(val)
		end
	end

	return self
end

function color:update(dt, heros)
	for k,attack in pairs(self.attacks) do
		-- print('Updating '..k)
		attack:update(dt, heros)
	end
end

function color:draw(heros)
	for k,attack in pairs(self.attacks) do
		-- print('Updating '..k)
		attack:draw(heros)
	end
end

return color
