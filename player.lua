--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  Pixa:player
-- /ddddy:oddddddddds:sddddd/ By Arnaud Debray - Arnaud Debray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-02-23 14:06:32
-- :ddddddddddhyyddddddddddd: Modified: 2015-02-23 15:59:09
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local player = {}

function player:make_relative() return makePoint(self.x, self.y) end
function player:make_absolute() return makePoint(screen.center.x + self.x, screen.center.y + self.y) end

function player:init()
	self.tileset = { image = love.newImage('img/tileset.png') }
	self.tileset.imagewidth = self.tileset.image:getWidth()
	self.tileset.imageheight = self.tileset.image:getHeight()

	self.tileset.width = 35
	self.tileset.height = 35
	self.Quads = Quadlist.new(self.tileset, self.tileset.width, self.tileset.height)

	self.x = 0
	self.y = 0
	self:update(0)
	return self
end

function player:update(dt)
	local player_offset = screen:getLine(player:make_absolute()) + 1
	self.vertical_offset = screen:getLine(screen.mouse:make()) - player_offset + screen.size / 2 + 1

	if self.vertical_offset < 1 then
		self.vertical_offset = 1
	end
end

function player:draw(x, y)
	love.graphics.draw(self.Quads[0], self.Quads[11],
		x + self.x, y + self.y,
		0, 1, 1,
		self.tileset.width / 2, 0)
	love.graphics.draw(self.Quads[0], self.Quads[self.vertical_offset],
		x + self.x, y + self.y,
		0, 1, 1,
		self.tileset.width / 2, self.tileset.height / 2)
end

return player
