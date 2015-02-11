inspect = require 'inspect'
socket = require 'socket'
protocol = require 'UDP'
clients = require 'clients'
server = require 'server'

function love.load()
	server:start()
end

function love.update(dt)
	server:serv(dt)
end

function love.draw()
	love.graphics.print("test")
end

-- function love.die()
-- 	server:die()
-- 	return false
-- end
