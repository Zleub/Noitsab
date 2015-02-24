--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  Pixa:screen
-- /ddddy:oddddddddds:sddddd/ By Arnaud Debray - Arnaud Debray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-02-23 03:28:59
-- :ddddddddddhyyddddddddddd: Modified: 2015-02-24 13:21:57
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local screen = {}

function screen:init(size)
	self.size = size
	self.width = love.window.getWidth()
	self.height = love.window.getHeight()
	self.miniwidth = self.width / size
	self.miniheight = self.height / size
	self.center = {}
	self.center.x = self.width / 2
	self.center.y = self.height / 2
	self.mouse = {}
	self.mouse.make = function (self) return makePoint(self.x, self.y) end
	self.mouse.x = love.mouse.getX()
	self.mouse.y = love.mouse.getY()

	return self
end

function screen:isInside(point, rectangle)
	if point.x > rectangle.x and point.x < rectangle.x + rectangle.width
	and point.y > rectangle.y and point.y < rectangle.y + rectangle.height
	then return true
	else return false end
end

function screen:getLine(point)
	return math.floor(point.y / self.miniheight)
end

function screen:getWidth()
	return math.floor(point.x / self.miniwidth)
end

function screen:update(dt)
	self.mouse.x = love.mouse.getX()
	self.mouse.y = love.mouse.getY()
	-- self:getLine(self.mouse:make())

	P1 = makePoint(self.center.x + player.x, self.center.y + player.y)
	P2 = makePoint(self.mouse.x, self.mouse.y)
	P3 = makePoint(self.center.x + player.x, 0)

	P12 = math.sqrt( (P1.x - P2.x)^2 + (P1.y - P2.y)^2 )
	P13 = math.sqrt( (P1.x - P3.x)^2 + (P1.y - P3.y)^2 )
	P23 = math.sqrt( (P2.x - P3.x)^2 + (P2.y - P3.y)^2 )

	-- print(x1 - x2, y1 - y2)
	player.angle = (math.acos( (P12^2 + P13^2 - P23^2) / (2 * P12 * P13) ) - (math.pi / 2))* player.chest
	if player.angle > 1.5 then player.angle = 1.5 end
	if player.angle < -1.5 then player.angle = -1.5 end
end

function screen:draw()
	-- print(player.angle)
	-- love.graphics.line(P1.x, P1.y, P2.x, P2.y)
	-- love.graphics.line(P1.x, P1.y, P3.x, P3.y)
	-- love.graphics.line(P2.x, P2.y, P3.x, P3.y)
	-- love.graphics.print(player.angle)

	-- local y = 0
	-- while y < self.height do
	-- 	local x = 0
	-- 	while x < self.width do
	-- 		if self:isInside(self.mouse:make(), makeRectangle(x, y, self.miniwidth, self.miniheight)) then
	-- 			love.graphics.setColor({100, x, y})
	-- 		else
	-- 			love.graphics.setColor({0, 0, 0})
	-- 		end
	-- 		love.graphics.rectangle('fill', x, y, self.miniwidth, self.miniheight)
	-- 		love.graphics.setColor({255, 255, 255})
	-- 		x = x + self.miniwidth
	-- 	end
	-- 	y = y + self.miniheight
	-- end
end

return screen
