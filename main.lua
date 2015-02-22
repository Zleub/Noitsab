inspect = require 'inspect'
-- Quadlist = require 'Quadlist'

-- function love.newImage(path) return love.graphics.newImage(path) end

-- function love.load()
-- 	width = love.window.getWidth()
-- 	height = love.window.getHeight()
-- 	test = love.window.getWidth() / 10

-- 	center = {}
-- 	center.x = love.window.getWidth() / 2
-- 	center.y = love.window.getHeight() / 2
-- 	center.drawLeft = function (self)
-- 		love.graphics.setColor({0, 255, 0, 100})
-- 		love.graphics.rectangle('fill', 0, 0, self.x - test, height)
-- 		love.graphics.setColor({255, 255, 255})
-- 	end
-- 	center.drawRight = function (self)
-- 		love.graphics.setColor({0, 255, 0, 100})
-- 		love.graphics.rectangle('fill', self.x + test, 0, width, height)
-- 		love.graphics.setColor({255, 255, 255})
-- 	end
-- 	center.draw = function (self)
-- 		self:drawLeft()
-- 		self:drawRight()
-- 		love.graphics.point(self.x, self.y)
-- 		love.graphics.setColor({255, 0, 0})
-- 		love.graphics.line(self.x, self.y, self.x, 0)
-- 		love.graphics.setColor({0, 255, 0})
-- 		love.graphics.line(self.x, self.y, self.x * 2, self.y)
-- 		love.graphics.setColor({255, 255, 255})
-- 	end

-- 	mouse = {}
-- 	mouse.x = love.mouse.getX()
-- 	mouse.y = love.mouse.getY()
-- 	mouse.update = function (self, dt, center)
-- 			mouse.x = love.mouse.getX()
-- 			mouse.y = love.mouse.getY()
-- 	end
-- 	mouse.draw = function (self)
-- 		love.graphics.point(self.x, self.y)
-- 	end

-- 	tileset = { image = love.newImage('img/tileset.png') }
-- 	tileset.imagewidth = tileset.image:getWidth()
-- 	tileset.imageheight = tileset.image:getHeight()

-- 	tileset.size_x = 35
-- 	tileset.size_y = 35
-- 	caca = Quadlist.new(tileset, tileset.size_x, tileset.size_y)
-- 	rpotu = 32
-- end

-- function love.update(dt)
-- 	mouse:update(dt, center)
-- end

-- function love.draw()
-- 	center:draw()

-- 	love.graphics.line(center.x, center.y, mouse.x, mouse.y)

-- 	-- love.graphics.print(inspect(center))
-- 	-- love.graphics.scale(3, 3)
-- 	-- for k,v in ipairs(caca) do
-- 	-- 	if k ~= 0 then
-- 	-- 		love.graphics.rectangle('line', rpotu * k, 50, tileset.size_x, tileset.size_y)
-- 	-- 		love.graphics.draw(caca[0], caca[k], rpotu * k, 50)
-- 	-- 	end
-- 	-- end
-- 	-- love.graphics.scale(1, 1)
-- end

-- function love.mousepressed(x, y, key)
-- 	if key == 'wu' then
-- 		rpotu = rpotu - 1
-- 	elseif key == 'wd' then
-- 		rpotu = rpotu + 1
-- 	end
-- end

function makePoint(x, y) return {x = x, y = y} end
function makeRectangle(x, y, width, height) return {x = x, y = y, width = width, height = height} end

screen = {}

function screen:init(size)
	self.width = love.window.getWidth()
	self.height = love.window.getHeight()
	self.miniwidth = self.width / size
	self.miniheight = self.height / size
	self.center = {}
	self.center.x = self.width / 2
	self.center.y = self.height / 2
	self.mouse = {}
	self:update(0)
end

function screen:isInside(point, rectangle)
	if point.x > rectangle.x and point.x < rectangle.x + rectangle.width
	and point.y > rectangle.y and point.y < rectangle.y + rectangle.height
	then return true
	else return false end
end

function screen:draw()
	local y = 0
	while y < self.height do
		local x = 0
		while x < self.width do
			-- if self:isInside(makePoint(self.mouse.x, self.mouse.y), makeRectangle(x, y, self.miniwidth, self.miniheight)) then
				love.graphics.setColor({0, x, y})
			-- else
			-- 	love.graphics.setColor({0, 0, 0})
			-- end
			love.graphics.rectangle('fill', x, y, self.miniwidth, self.miniheight)
			love.graphics.setColor({255, 255, 255})
			x = x + self.miniwidth
		end
		y = y + self.miniheight
	end
end

function screen:update(dt)
	self.mouse.x = love.mouse.getX()
	self.mouse.y = love.mouse.getY()
end

function love.load()
	screen:init(8)
end

function love.update(dt)
	screen:update(dt)
end

function love.draw()
	screen:draw()
end
