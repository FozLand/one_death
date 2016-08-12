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
