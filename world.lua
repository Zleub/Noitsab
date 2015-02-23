--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  Pixa:world
-- /ddddy:oddddddddds:sddddd/ By Arnaud Debray - Arnaud Debray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-02-23 14:21:35
-- :ddddddddddhyyddddddddddd: Modified: 2015-02-23 15:53:52
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

player = require 'player'

local world = {}

function world:init()
	self.g_rate = 80
	return self
end

function world:update(dt)
	if player.y < screen.height / 2 - player.tileset.height then
		player.y = player.y + dt * self.g_rate
	end
	player:update(dt)
end

function world:draw()
	player:draw(screen.center.x, screen.center.y)
end

return world
