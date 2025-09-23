local maxGibLifetime = 10 -- All serverside gibs will be force-removed after this many seconds.
local noGibModels = { -- Prevents gibs from ever spawning out of these models.
    ["models/props/cs_office/computer_caseb.mdl"] = true,
    ["models/props/cs_office/computer_monitor.mdl"] = true,
    ["models/props/cs_office/phone.mdl"] = true,
    ["models/props/cs_office/radio.mdl"] = true
}

hook.Add( "PropBreak", "CFC_NoGibs_RemovePropOnBreak", function( _, prop )
    if not IsValid( prop ) then return end

    local model = prop:GetModel()
    model = string.Replace( model, "\\", "/" )
    model = string.lower( model )

    if not noGibModels[model] then return end

    prop:Remove()
end )

-- Force-remove any and all serverside gib entities with a delay.
hook.Add( "InitPostEntity", "CFC_NoGibs_StartRemovingGibs", function() -- Ignore the tons of map/engine ents that spawn on map load.
    hook.Add( "OnEntityCreated", "CFC_NoGibs_DelayedRemoveGibs", function( ent )
        if not IsValid( ent ) then return end
        if ent:GetClass() ~= "gib" then return end

        SafeRemoveEntityDelayed( ent, maxGibLifetime )
    end )
end )
