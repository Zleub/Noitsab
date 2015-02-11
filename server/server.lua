server = {}

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

function server:match(data)
	id, cmd, args = data:match("(%d*) (%a*) (.*)")
	if id then
		if clients[cmd] then
			local client = clients:get(id)

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
end

function server:serv(dt)
	local data, msg_or_ip, port_or_nil = self.udp:receivefrom()
	if not data then return end

	if data == "dump" then
		clients:dump()
	end

	if tonumber(data) == protocol.magic then
		local nbr = clients:add(msg_or_ip, port_or_nil)
		self.udp:sendto(nbr, msg_or_ip, port_or_nil)
	end

	self:match(data)
end

function server:die()
	clients:down()
end

return server
