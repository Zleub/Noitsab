inspect = require 'inspect'
socket = require 'socket'
protocol = require 'UDP'

clients = {
	list = {}
}

function clients:is_id(id)
	for k,v in pairs(self.list) do
		if v.id == id then
			print('id: '..id..' is already in use')
			return true
		end
	end
	return false
end

function clients:add(ip, port)
	nbr = love.math.random(0, 42)
	while self:is_id(nbr) do
		nbr = love.math.random(0, 42)
	end

	print('adding a new client to list: ', ip, port, nbr)
	table.insert(self.list, {
		ip = ip,
		port = port,
		id = nbr
	})
end

function clients:dump()
	print(inspect(self.list))
end

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

function serving:serv(dt)
	local data, msg_or_ip, port_or_nil = self.udp:receivefrom()

	if data then print(data, msg_or_ip, port_or_nil) end

	if data == "dump" then
		clients:dump()
	end

	if tonumber(data) == protocol.magic then
		clients:add(msg_or_ip, port_or_nil)
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
