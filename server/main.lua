inspect = require 'inspect'
socket = require 'socket'

serving = {}

function serving:start()
	if arg[2] == nil or arg[3] == nil then
		print('Plz, specify IP or PORT')
		love.event.quit()
	else
		self.udp = socket.udp()
		self.udp:setsockname(arg[2], arg[3])
		self.udp:settimeout(0)
	end
end

function serving:getline(line)
	if line == 'exit' then
		return -1
	end
end

-- NOTION OF MULTI-CLIENT IS MISSING HERE
-- A LIST OF CLIENT AND CHECK IN BUFFER IS REQUIRED

function serving:serv(dt)
	local data, msg_or_ip, port_or_nil = self.udp:receivefrom()

	if data then
		print(data, msg_or_ip, port_or_nil)
	end
end

function love.load()
	serving:start()
end

function love.update(dt)
	serving:serv(dt)
end

function love.draw()
	love.graphics.print("test")
end
