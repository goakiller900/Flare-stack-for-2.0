local ITEM_BURN_RATE_TOOLTIP = {}
if settings.startup["flare-stack-item-rate"].value == 1 then
  ITEM_BURN_RATE_TOOLTIP = {"flare-tooltips.item-burn-rate-single", settings.startup["flare-stack-item-rate"].value}
else
  ITEM_BURN_RATE_TOOLTIP = {"flare-tooltips.item-burn-rate", settings.startup["flare-stack-item-rate"].value}
end
local FLUID_BURN_RATE_TOOLTIP = {"flare-tooltips.fluid-burn-rate", settings.startup["flare-stack-fluid-rate"].value}
 
data:extend(
{
  -- Flare Stack *************************************************************************
  {
    type = "furnace",
    name = "flare-stack",
    localised_description = "flare-tooltips.fluid-burn-rate "..settings.startup["flare-stack-fluid-rate"].value,
    icon = "__Flare_Stack_Goa__/graphics/icon/flare-stack.png",
    icon_size = 32,
    flags = {"placeable-neutral","player-creation"},
    minable = {mining_time = 1, result = "flare-stack"},
    fast_replaceable_group = "fluid-incinerator",
    max_health = 250,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    crafting_categories = {"flaring"},
    crafting_speed = settings.startup["flare-stack-item-rate"].value,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 8 }
    },
    energy_usage = "1kW",
    ingredient_count = 1,
    source_inventory_size = 0,
    result_inventory_size = 0,
	graphics_set =
	{
	  animation =
	  {
	    filename = "__Flare_Stack_Goa__/graphics/entity/flare-stack.png",
	    priority = "extra-high",
	    width = 160,
	    height = 160,
	    shift = {1.5, -1.59375}
	  },
	  working_visualisations =
	  {
	    {
	  	  animation =
	  	  {
	  	    filename = "__Flare_Stack_Goa__/graphics/entity/flare-stack-fire.png",
	  	    priority = "extra-high",
	  	    frame_count = 29,
	  	    width = 48,
	  	    height = 105,
	  	    shift = {0, -5},
	  	    run_mode="backward"
	  	  },
	  	  light = {intensity = 1, size = 32},
	  	  constant_speed = true
	      }
	  },
	},
    vehicle_impact_sound =
    {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    },
    working_sound =
    {
      sound = { filename = "__base__/sound/oil-refinery.ogg" },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
      apparent_volume = 2.5,
    },
	fluid_boxes =
    {
      {
	    production_type = "input",
        pipe_covers = pipecoverspictures(),
        volume = settings.startup["flare-stack-fluid-rate"].value * 10,
        pipe_connections = {{ flow_direction="input", direction = defines.direction.north, position = {0, 0} }},
      },
    },
  },
 
  -- Incinerator smoke
  {
    type = "trivial-smoke",
    name = "incinerator-smoke",
    duration = 150,
    fade_in_duration = 0,
    fade_away_duration = 100,
    spread_duration = 100,
    start_scale = 0.4,
    end_scale = 1.5,
    color = {r = 0.3, g = 0.3, b = 0.3, a = 0.3},
    cyclic = true,
    affected_by_wind = true,
    animation =
    {
      width = 152,
      height = 120,
      line_length = 5,
      frame_count = 60,
      shift = {-0.53125, -0.4375},
      priority = "high",
      animation_speed = 0.25,
      filename = "__base__/graphics/entity/smoke/smoke.png",
      flags = { "smoke" }
    }
  }
})

-- Incinerator ***************************************************************************
incinerator = (util.table.deepcopy(data.raw["furnace"]["flare-stack"]))
incinerator.name = "incinerator"
incinerator.localised_description = "flare-tooltips.item-burn-rate "..settings.startup["flare-stack-item-rate"].value
incinerator.icon = "__Flare_Stack_Goa__/graphics/icon/incinerator.png"
incinerator.minable = {mining_time = 1, result = "incinerator"}
incinerator.fast_replaceable_group = "item-incinerator"
incinerator.crafting_categories = {"incineration"}
incinerator.crafting_speed = settings.startup["flare-stack-item-rate"].value
incinerator.energy_usage = "320kW"
incinerator.working_visualisations = nil
incinerator.graphics_set.animation.filename = "__Flare_Stack_Goa__/graphics/entity/incinerator.png"
incinerator.energy_source =
{
  type = "burner",
  effectivity = 1,
  fuel_inventory_size = 1,
  emissions_per_minute = { pollution = 8 },
  light_flicker =
  {
    minimum_intensity = 0,
    maximum_intensity = 0
  },    
  smoke =
  {
    {
      name = "incinerator-smoke",
      deviation = {0.1, 0.1},
      frequency = 15,
      north_position = {0.0, -4},
      south_position = {0.0, -4},
      east_position = {0.0, -4},
      west_position = {0.0, -4},
      starting_vertical_speed = 0.08,
      starting_frame_deviation = 60
    }
  }
}
incinerator.source_inventory_size = 1
incinerator.fluid_boxes = nil

-- Electric Incinerator ******************************************************************
eincinerator = (util.table.deepcopy(incinerator))
eincinerator.name = "electric-incinerator"
eincinerator.localised_description = "flare-tooltips.item-burn-rate "..settings.startup["flare-stack-item-rate"].value
eincinerator.icon = "__Flare_Stack_Goa__/graphics/icon/electric-incinerator.png"
eincinerator.minable = {mining_time = 1, result = "electric-incinerator"}
eincinerator.fast_replaceable_group = "item-incinerator"
eincinerator.crafting_categories = {"incineration", "fuel-incineration"}
eincinerator.crafting_speed = settings.startup["flare-stack-item-rate"].value
eincinerator.energy_usage = "320kW"
eincinerator.energy_source =
{
  type = "electric",
  usage_priority = "secondary-input",
  emissions_per_minute = { pollution = 8 },
  drain = "0W"
}
eincinerator.working_visualisations =
{
  {
    animation =
    {
      filename = "__Flare_Stack_Goa__/graphics/entity/electric-incinerator-smoke.png",
      priority = "extra-high",
      frame_count = 29,
      width = 48,
      height = 105,
      shift = {-0.05, -5.65},
      animation_speed = 0.4,
      scale = 1.5,
      run_mode="backward"
    },
    constant_speed = true
  }
}

-- Vent Stack ****************************************************************************
ventstack = (util.table.deepcopy(data.raw["furnace"]["flare-stack"]))
ventstack.name = "vent-stack"
ventstack.localised_description = "flare-tooltips.fluid-burn-rate "..settings.startup["flare-stack-fluid-rate"].value
ventstack.icon = "__Flare_Stack_Goa__/graphics/icon/vent-stack.png"
ventstack.minable = {mining_time = 1, result = "vent-stack"}
ventstack.fast_replaceable_group = "fluid-incinerator"
ventstack.crafting_categories = {"flaring"}
ventstack.crafting_speed = settings.startup["flare-stack-fluid-rate"].value
ventstack.energy_source.emissions_per_minute = { pollution = 8 }
ventstack.working_visualisations =
{
  {
    animation =
    {
      filename = "__Flare_Stack_Goa__/graphics/entity/vent-stack-fumes.png",
      priority = "extra-high",
      frame_count = 29,
      width = 48,
      height = 105,
      shift = {-0.05, -5.65},
      animation_speed = 0.5,
      scale = 1.5,
      run_mode="backward"
    },
    constant_speed = true
  }
}
ventstack.graphics_set.animation.filename = "__Flare_Stack_Goa__/graphics/entity/vent-stack.png"
 
data:extend(
{
  incinerator,
  eincinerator,
  ventstack
})
