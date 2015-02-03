inspect = require 'inspect'
socket = require 'socket'

serving = {}

function serving:start()
	self.server = assert(socket.bind("10.11.12.16", 4242))
	self.ip, self.port = self.server:getsockname()
	print('Serving start on '..self.ip..':'..self.port)
	self.server:settimeout(2)
end

function serving:getline(line)
	if line == 'exit' then
		return -1
	end
end

-- NOTION OF MULTI-CLIENT IS MISSING HERE
-- A LIST OF CLIENT AND CHECK IN BUFFER IS REQUIRED

function serving:serv(dt)
	print('serving ... '..dt)
	local client = self.server:accept()

	if client then
		client:settimeout(10)
		local line, err = client:receive()
		if not err then
			print(line)
			-- client:send(line.."\n")
			if self:getline(line) == -1 then
				client:close()
			end
		end
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
