--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  Pixa:player
-- /ddddy:oddddddddds:sddddd/ By Arnaud Debray - Arnaud Debray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-02-23 14:06:32
-- :ddddddddddhyyddddddddddd: Modified: 2015-02-24 14:07:09
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

	self.jump_delay = 0
	self.jump_delay_max = 200
	self.jump_strengh = world.g_rate * 1.2
	self.movment = 1
	self.movment_rate = 200

	self:update(0)
	return self
end

function player:update(dt)
	local timer
	if not timer then timer = dt else timer = timer + dt end

	self.timer = math.floor(timer)

	local player_offset = screen:getLine(player:make_absolute()) + 1
	self.vertical_offset = screen:getLine(screen.mouse:make()) - player_offset + screen.size / 2 + 1

	if self.vertical_offset < 1 then
		self.vertical_offset = 1
	end

	if self.x + screen.width / 2 < screen.mouse.x then self.chest = 1 else self.chest = -1 end

	if love.keyboard.isDown('q') then
		self.x = self.x - dt * self.movment_rate
		self.movment = -1
	end
	if love.keyboard.isDown('d') then
		self.x = self.x + dt * self.movment_rate
		self.movment = 1
	end

	if self.jump_delay > 0 then
		self.y = self.y - dt * (self.jump_strengh + self.jump_delay)
		self.horizontal_offset = math.abs(3 -math.floor(self.jump_delay / (self.jump_delay_max / 4))) + 21
		self.jump_delay = self.jump_delay - dt * self.jump_strengh
	else
		self.horizontal_offset = (self.timer * 10) % 2 + 11
		if love.keyboard.isDown(' ') and player.state ~= 'fall' then
			self.jump_delay = self.jump_delay_max
		end
	end
end

function player:draw(x, y)
	love.graphics.draw(self.Quads[0], self.Quads[self.horizontal_offset],
		x + self.x, y + self.y,
		0, self.movment, 1,
		self.tileset.width / 2, 0)
	love.graphics.draw(self.Quads[0], self.Quads[self.vertical_offset],
		x + self.x, y + self.y,
		0, self.chest, 1,
		self.tileset.width / 2, self.tileset.height / 2)
end

return player
