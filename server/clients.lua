local clients = {
	list = {}
}

function clients:Get(id)
	for k, client in ipairs(self.list) do
		if tonumber(client.id) == tonumber(id) then
			return client
		end
	end
end

function clients:isAlive(id)
	for k,v in pairs(self.list) do
		if v.id == id then
			print('id: '..id..' is already in use')
			return true
		end
	end
	return false
end

function clients:newClient(ip, port)
	print('adding a new client to list: ', ip, port, nbr)

	new_client = {
		id = nbr,
		ip = ip,
		port = port,

		-- x = map.UberRectangle.center_x,
		-- y = map.UberRectangle.center_y,

		color = {255, 255, 255},

		shape = HC:addCircle(map.UberRectangle.center_x, map.UberRectangle.center_y, 1),

		collides = function (self)
			local neighbors = self.shape:neighbors()
			for k,v in pairs(neighbors) do
				if self.shape:collidesWith(v) and v._radius ~= 1 then
					return true
				end
			end
			return false
		end,

		move = function (self, x, y)
			if x == nil then x = 0 end
			if y == nil then y = 0 end

			local collides = self:collides()
			if collides == true then
				self.shape:move(x, y)
				if self:collides() == false then
					self.shape:move(-x, -y)
					collides = false
				end
			end
			return collides
		end
	}

	table.insert(self.list, new_client)
	return new_client
end

function clients:addClient(ip, port)
	nbr = love.math.random(0, 42)
	while self:isAlive(nbr) do
		nbr = love.math.random(0, 42)
	end

	return self:newClient(ip, port)
end

function clients:position(id, args)
	-- print('position callback', id, args)
	x, y = args:match('(.*) (.*)')
	client = self:Get(id)
	return client:move(tonumber(x), tonumber(y))
end

function clients:die(id)
	print(id..' is dead')
	for k,client in ipairs(self.list) do
		if tonumber(client.id) == tonumber(id) then
			table.remove(self.list, k)
		end
	end
	return true
end

function clients:dump()
	print(inspect(self.list))
end

return clients
