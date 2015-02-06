inspect = require 'inspect'

function love.load()
	heros = require 'heros'
	heros:load( dofile(arg[1]..'/color.lua'):load('white') )
end

function love.update(dt)
	heros:update(dt)
end

function love.draw()
	heros:dump()
	heros:draw()
end

-- function love.keypressed(key, unicode)
-- 	heros:keypressed(key, unicode)
-- end

-- function love.keyreleased(key, unicode)
-- 	heros:keyreleased(key, unicode)
-- end
