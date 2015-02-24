--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  Pixa:main
-- /ddddy:oddddddddds:sddddd/ By Arnaud Debray - Arnaud Debray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-02-23 02:44:03
-- :ddddddddddhyyddddddddddd: Modified: 2015-02-24 13:22:56
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

inspect = require 'inspect'
screen = require 'screen'
Quadlist = require 'Quadlist'
world = require 'world'

function love.newImage(path)
	local img = love.graphics.newImage(path)
	img:setFilter('nearest')
	return img
end

function makePoint(x, y) return {x = x, y = y} end
function makeRectangle(x, y, width, height) return {x = x, y = y, width = width, height = height} end

function love.load()
	screen:init(8)
	print(inspect(screen))
	world:init()
	player:init()
end

function love.update(dt)
	screen:update(dt)
	world:update(dt)
end

function love.draw()
	screen:draw()
	world:draw()
end
