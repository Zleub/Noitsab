--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  Pixa:Quadlist
-- /ddddy:oddddddddds:sddddd/ By Arnaud Debray - Arnaud Debray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-02-23 02:44:03
-- :ddddddddddhyyddddddddddd: Modified: 2015-02-23 04:07:29
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Quadlist = {}

function Quadlist.new(tileset, width, height)
	local i = 0
	local j = 0
	local Quadlist = {}

	Quadlist[0] = tileset.image
	while j < tileset.imageheight do
		i = 0
		while i < tileset.imagewidth do
			table.insert(Quadlist,
				love.graphics.newQuad(i, j, width, height,
					tileset.imagewidth, tileset.imageheight))
			i = i + width
		end
		j = j + height
	end

	return Quadlist
end

return Quadlist
