--[[
MIT License

Copyright (c) 2016 John Cole

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]

-- Track dead players to only trigger on_dieplayer callbacks once per death.
local is_dead = {}

-- Override all previous on_dieplayer callbacks with this one
local callbacks = table.copy(core.registered_on_dieplayers)

for k,_ in pairs(core.registered_on_dieplayers) do
	core.registered_on_dieplayers[k] = nil
end

core.register_on_dieplayer(function(player)
	local player_name = player:get_player_name()
	if is_dead[player_name] then
		return
	else
		is_dead[player_name] = true
	end

	for _, callback in pairs(callbacks) do
		callback(player)
	end
end)

minetest.register_on_respawnplayer(function(player)
	is_dead[player:get_player_name()] = nil
end)
