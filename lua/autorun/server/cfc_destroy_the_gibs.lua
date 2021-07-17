local noGibModels = {
    ["models/props/cs_office/computer_caseb.mdl"] = true,
    ["models/props/cs_office/computer_monitor.mdl"] = true,
    ["models/props/cs_office/phone.mdl"] = true,
    ["models/props/cs_office/radio.mdl"] = true
}

hook.Add( "PropBreak", "CFC_NoGibs_RemovePropOnBreak", function( attacker, prop )
    if not IsValid( prop ) then return end

    local model = prop:GetModel()
    model = string.Replace( model, "\\", "/" )
    model = string.lower( model )

    if not noGibModels[model] then return end

    prop:Remove()
end)
