local attack = {}

function attack:load(attack)
	print('new attack '..attack)
	for k,v in pairs( dofile(arg[1]..'/skills/'..attack..'.conf.lua') ) do
		self[k] = v
	end
	return self
end

function attack:update(dt)
end

function attack:draw()
end

return attack
