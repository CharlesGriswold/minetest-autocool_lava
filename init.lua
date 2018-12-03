for _, block in ipairs ({"obsidian", "obsidianbrick", "obsidian_block"}) do
	minetest.override_item("default:" .. block, {
		paramtype = "light",
		light_source = LIGHT_MAX,
	})
end

--
-- Lavacooling
--

default.cool_lava = function(pos, node)
	if node.name == "default:lava_source" then
		minetest.set_node(pos, {name = "default:obsidian"})
	else -- Lava flowing
		minetest.set_node(pos, {name = "air"})
	end
	minetest.sound_play("default_cool_lava",
		{pos = pos, max_hear_distance = 16, gain = 0.25})
end

if minetest.settings:get_bool("enable_lavacooling") ~= false then
	minetest.register_abm({
		label = "Lava cooling",
		nodenames = {"default:lava_source", "default:lava_flowing"},
		neighbors = {
			"group:cools_lava",
			"default:lava_flowing",
			"default:lava_source",
			"default:obsidian",
			"group:lava",
			"group:sand",
			"group:soil",
			"group:stone", 
			"group:water",
			"group:wood",
			"air"
		},
		interval = 2,
		chance = 2,
		catch_up = false,
		action = function(...)
			default.cool_lava(...)
		end,
	})
end

