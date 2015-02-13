local map = {
	list = { -- SHAPE SUPPORT: circle || rectangle
		{
			shape = 'circle',
			radius = 300,
			x = 400,
			y = 400
		},
		{
			shape = 'rectangle',
			width = 100,
			height = 200,
			x = 100,
			y = 200
		},
		{
			shape = 'circle',
			radius = 30,
			x = 700,
			y = 500
		},
		{
			shape = 'rectangle',
			width = 350,
			height = 500,
			x = 400,
			y = 500
		},
	},
	createUberRectangle = function (self)
		self.UberRectangle = {
			min_x = 1000000,
			min_y = 1000000,
			max_x = 0,
			max_y = 0
		}

		for k,v in ipairs(self.list) do
			local min_x
			local min_y
			local max_x
			local max_y

			if v.shape == 'circle' then
				min_x = v.x - v.radius
				min_y = v.y - v.radius
				max_x = v.x + v.radius
				max_y = v.y + v.radius
			elseif v.shape == 'rectangle' then
				min_x = v.x
				min_y = v.y
				max_x = v.x + v.width
				max_y = v.y + v.height
			end

			if min_x < self.UberRectangle.min_x then
				self.UberRectangle.min_x = min_x
			end
			if min_y < self.UberRectangle.min_y then
				self.UberRectangle.min_y = min_y
			end
			if max_x > self.UberRectangle.max_x then
				self.UberRectangle.max_x = max_x
			end
			if max_y > self.UberRectangle.max_y then
				self.UberRectangle.max_y = max_y
			end
		end
		self.UberRectangle.center_x = (self.UberRectangle.max_x - self.UberRectangle.min_x) / 2 + self.UberRectangle.min_x
		self.UberRectangle.center_y = (self.UberRectangle.max_y - self.UberRectangle.min_y) / 2 + self.UberRectangle.min_y
	end,

	createShapes = function (self)
		self.shapes = {}
		for k,v in pairs(self.list) do
			if v.shape == 'circle' then
				table.insert(self.shapes, HC:addCircle(v.x, v.y, v.radius))
			elseif v.shape == 'rectangle' then
				table.insert(self.shapes, HC:addRectangle(v.x, v.y, v.width, v.height))
			end
		end
	end
}

return map
