clients = require 'clients'
map = require 'map'

local server = {}

function server:start()
	if arg[2] == nil or arg[3] == nil then
		print('Plz, specify IP or PORT')
		love.event.quit()
	else
		self.udp = socket.udp()
		self.udp:setsockname(arg[2], arg[3])
		self.udp:settimeout(0)
	end
end

function server:responde(id, cmd, args)
	if clients[cmd] then
		local client = clients:Get(id)

		if clients[cmd](clients, id, args) then
			self.udp:sendto('ok', client.ip, client.port)
		else
			self.udp:sendto('ko', client.ip, client.port)
		end
	else
		print('I got some junk message: ')
		print(cmd)
	end
end

function server:match(data, ip, port)
	id, cmd, args = data:match("(%d*) (%a*) (.*)")
	if id then
		self:responde(id, cmd, args)
	end

	if tonumber(data) == protocol.magic then
		self:newClient(data, ip, port)
	end
end

function server:newClient(data, ip, port)
	local nbr = clients:newClient(ip, port)
	self.udp:sendto(nbr, ip, port)
end

function server:update(dt)
	local data, msg_or_ip, port_or_nil = self.udp:receivefrom()

	if not data then return end

	if data == "dump" then
		clients:dump()
	end

	self:match(data, msg_or_ip, port_or_nil)
end

function server:die()
	clients:down()
end

return server
