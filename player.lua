--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  Pixa:player
-- /ddddy:oddddddddds:sddddd/ By Arnaud Debray - Arnaud Debray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-02-23 14:06:32
-- :ddddddddddhyyddddddddddd: Modified: 2015-03-03 21:24:45
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local player = {}

function player:make_relative() return makePoint(self.x, self.y) end
function player:make_absolute() return makePoint(screen.center.x + self.x, screen.center.y + self.y) end

function player:init()
	self.tileset = { image = love.newImage('img/tileset2.png') }
	self.tileset.imagewidth = self.tileset.image:getWidth()
	self.tileset.imageheight = self.tileset.image:getHeight()

	self.tileset.width = 64
	self.tileset.height = 64
	self.Quads = Quadlist.new(self.tileset, self.tileset.width, self.tileset.height)

	self.x = 0
	self.y = 0

	self.jump_delay = 0
	self.jump_delay_max = 300
	self.jump_strengh = world.g_rate * 1.5
	self.movment = 1
	self.movment_rate = 200
	self.movment_timer = 0
	self.movment_offset = 11

	self.timer = 0
	self.angle = 0
	self:update(0)
	return self
end

function player:move(dt)
	if love.keyboard.isDown('q') then
		self.x = self.x - dt * self.movment_rate
		self.movment = -1
	end
	if love.keyboard.isDown('d') then
		self.x = self.x + dt * self.movment_rate
		self.movment = 1
	end

	if love.keyboard.isDown('d', 'q') then
		self.movment_timer = self.movment_timer + dt
		self.movment_offset = math.floor(self.movment_timer * 10) + 31
		if self.movment_offset > 38 then
			self.movment_timer = 0
		end
		if love.keyboard.isDown('d') and love.keyboard.isDown('q') then
			self.movment_offset = math.floor(self.timer) % 2 + 11
			self.movment_timer = 0
		end
	else
		self.movment_offset = math.floor(self.timer) % 2 + 11
		self.movment_timer = 0
	end
end

function player:update(dt)
	self.timer = self.timer + dt

	local player_offset = screen:getLine(player:make_absolute()) + 1
	self.vertical_offset = screen:getLine(screen.mouse:make()) - player_offset + screen.size / 2 + 2

	if self.vertical_offset < 1 then
		self.vertical_offset = 1
	elseif self.vertical_offset > 8 then
		self.vertical_offset = 8
	end

	if self.x + screen.width / 2 < screen.mouse.x then self.chest = 1 else self.chest = -1 end

	self:move(dt)

	if self.jump_delay > 0 then
		self.y = self.y - dt * (self.jump_strengh + self.jump_delay)
		self.jump_delay = self.jump_delay - dt * self.jump_strengh
		self.movment_offset = math.abs(3 -math.floor(self.jump_delay / (self.jump_delay_max / 4))) + 21
	elseif player.fall == 1 then
		self.movment_offset = 3 + 21
	else
		if love.keyboard.isDown(' ') and player.fall == 0 then
			self.jump_delay = self.jump_delay_max
		end
	end
end

function player:draw(x, y)
	love.graphics.draw(self.Quads[0], self.Quads[self.movment_offset],
		x + self.x, y + self.y,
		0, self.movment, 1,
		self.tileset.width / 2, 10)

	love.graphics.draw(self.Quads[0], self.Quads[self.vertical_offset],
		x + self.x, y + self.y,
		0, self.chest, 1,
		self.tileset.width / 2, 32)

	love.graphics.draw(self.Quads[0], self.Quads[41],
		x + self.x, y + self.y + 8,
		self.angle, self.chest, 1,
		32, 32)

-- love.graphics.circle('fill', x + self.x, y + self.y + 8, 2)

end

return player
