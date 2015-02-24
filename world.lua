--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  Pixa:world
-- /ddddy:oddddddddds:sddddd/ By Arnaud Debray - Arnaud Debray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-02-23 14:21:35
-- :ddddddddddhyyddddddddddd: Modified: 2015-02-24 13:50:38
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

player = require 'player'

local world = {}

function world:init()
	self.g_rate = 300
	self.fall_time = 0
	return self
end

function world:update(dt)
	if player.y + dt * self.g_rate < screen.height / 2 - player.tileset.height then
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
	player:draw(screen.center.x, screen.center.y)
end

return world
