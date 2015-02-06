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
	red = {255, 0, 0},
	green = {0, 255, 0},
	blue = {0, 0, 255},
	white = {255, 255, 255}
}

function color:load(enum)
	for k,v in pairs(self.enum) do
		if v == enum then
			self.color = enum
		end
	end
	return self
end

function color:update(dt)
end

return color
