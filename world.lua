--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  Pixa:world
-- /ddddy:oddddddddds:sddddd/ By Arnaud Debray - Arnaud Debray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-02-23 14:21:35
-- :ddddddddddhyyddddddddddd: Modified: 2015-02-26 01:07:16
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

player = require 'player'

local world = {}

function world:init()
	self.tileset = { image = love.newImage('img/PrtWeed.png') }
	self.tileset.imagewidth = self.tileset.image:getWidth()
	self.tileset.imageheight = self.tileset.image:getHeight()

	self.Quadlist = Quadlist.new(self.tileset, 32, 32)
	self:initScreen(32, 32)

	self.list = dofile('map.lua')
	self.g_rate = 300
	self.fall_time = 0
	print(inspect(self))
	return self
end

function world:initScreen(width, height)
	self.Screen = {}

	local i = 0
	while i < screen.width do
		local j = screen.height
		while j > 0 do
			table.insert(self.Screen, {x = i, y = j})
			j = j - height
		end
		i = i + width
	end
end

-- function world:getTile()
-- 	local x = player.x
-- 	local y = player.y

-- 	local width = screen.width
-- 	local height = screen.height
-- 	for key, column in ipairs(self.list) do
-- 		for k, val in ipairs(column) do

-- 			if x < 0 + 32 * (key - 1) , height - 32 * k
-- 		end
-- 	end
-- end

function world:update(dt)
	-- self.actual = self:getTile()
	if player.y + dt * self.g_rate < screen.height / 2 - 32 then
		player.y = player.y + dt * self.g_rate
		self.fall_time = self.fall_time + dt
		player.fall = 1
	else
		-- self.g_rate = 30
		-- player.jump_strengh = self.g_rate * 2
		self.fall_time = 0
		player.fall = 0
	end
	player:update(dt)
end

function world:draw()
	local width = screen.width
	local height = screen.height
	for key, column in ipairs(self.list) do
		for k, val in ipairs(column) do
			love.graphics.draw(self.Quadlist[0], self.Quadlist[val],
				0 + 32 * (key - 1), height - 32 * k)
		end
	end

	local i = 0
	for k,v in ipairs(self.Screen) do
		love.graphics.rectangle('line', v.x, v.y, 30, 30)
		love.graphics.print(i, v.x, v.y)
		i = i + 1
	end

	player:draw(screen.center.x, screen.center.y)
end

return world
