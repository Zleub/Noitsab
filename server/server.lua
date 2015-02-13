Collider = require "hardoncollider"
clients = require 'clients'
map = require 'map'

local server = {}

function server:build_map()

end

function server:init()
	HC = Collider.new(150)

	map:createUberRectangle()
	map:createShapes()

	udp = socket.udp()
	udp:setsockname(arg[2], arg[3])
	udp:settimeout(0)
end

function server:start()
	if arg[2] == nil or arg[3] == nil then
		print('Plz, specify IP or PORT')
		love.event.quit()
	else
		self:init()
	end
end

function server:responde(id, cmd, args)
	if clients[cmd] then
		local client = clients:Get(id)

		if clients[cmd] then
			clients[cmd](clients, id, args)
		else
			print('I got some junk message: ')
			print(cmd)
		end
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
	print(data, ip, port)
	local client = clients:addClient(ip, port)
	udp:sendto(client.id.." "..client.shape._center.x.." "..client.shape._center.y, ip, port)
end

function server:update(dt)
	local data, msg_or_ip, port_or_nil = udp:receivefrom()

	if not data then return end

	if data == "dump" then
		clients:dump()
	end

	self:match(data, msg_or_ip, port_or_nil)
end

function server:draw()
	for k,v in pairs(map.shapes) do
		v:draw('line')
	end
	love.graphics.setColor(0, 0, 0)
	for k,v in pairs(map.shapes) do
		v:draw('fill')
	end
	love.graphics.setColor(255, 255, 255)

	for k,v in pairs(clients.list) do
		v.shape:draw()
	end

	-- love.graphics.print(inspect(map.UberRectangle))
	-- love.graphics.rectangle('line', map.UberRectangle.min_x, map.UberRectangle.min_y,
	-- 	map.UberRectangle.max_x - map.UberRectangle.min_x, map.UberRectangle.max_y - map.UberRectangle.min_y)
end

function server:die()
	clients:down()
end

return server
