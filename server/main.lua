inspect = require 'inspect'
socket = require 'socket'
protocol = require 'UDP'
server = require 'server'

function love.load()
	server:start()
end

function love.update(dt)
	server:update(dt)
end

function love.draw()
	server:draw()
end

-- function love.die()
-- 	server:die()
-- 	return false
-- end
