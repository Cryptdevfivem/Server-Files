inRedZone = false
local timeLeft = 0
local currentRedZone = nil
local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

zones = {
    {name = "Rebel", coords = vector3(1457.4250488281,6308.064453125,63.868026733398), blipWidth = 130.0, blipColour = 1},
    {name = "Heroin", coords = vector3(3536.8837890625,3731.7326660156,54.534358978271), blipWidth = 200.0, blipColour = 1},
    {name = "NEW LSD", coords = vector3(2503.6752929688,-383.56991577148,94.120590209961), blipWidth = 135.0, blipColour = 1},
    {name = "LargeArms", coords = vector3(-1100.7934570313,4940.5952148438,218.35412597656), blipWidth = 130.0, blipColour = 1},
    {name = "LargeArmsCayo", coords = vector3(5115.7465820312, -4623.2915039062, 2.642692565918), blipWidth = 85.0, blipColour = 1},
    {name ="RebelCayo", coords =  vector3(4982.5634765625, -5175.1079101562, 2.4887988567352), blipWidth = 120.0, blipColour = 1},
}

Citizen.CreateThread(function()
    for k, v in pairs(zones) do
        local blip = AddBlipForRadius(v.coords, v.blipWidth)
        SetBlipColour(blip, v.blipColour)
        SetBlipAlpha(blip, 128)
    end

    while true do
        Citizen.Wait(0)
        for k, v in pairs(zones) do
            if isInArea(v.coords, v.blipWidth) and not inRedZone then
                timeLeft = 0
                inRedZone = true
                currentRedZone = k
            end
            if isInArea(v.coords, v.blipWidth) == false and inRedZone and currentRedZone == k then
                if timeLeft == 0 then
                    inRedZone = false
                else
                    TaskGoStraightToCoord(PlayerPedId(), v.coords, 2.0, 100.0, 307.0, 1.0)
                    if HasScaleformMovieLoaded(scaleform) then
                        PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
                        BeginTextComponent("STRING")
                        AddTextComponentString("~r~Return to the redzone!")
                        EndTextComponent()
                        PopScaleformMovieFunctionVoid()
                        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
                    end
                    SetTimeout(1000, function()
                        ClearPedTasks(PlayerPedId())
                    end)
                end
            end
        end

        if inRedZone then
            if IsPedShooting(PlayerPedId()) then
                timeLeft = 0
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if inRedZone then
            if timeLeft > 0 then
                timeLeft = timeLeft - 1
            end
        end
    end
end)

function isInArea(v, dis) 
    if #(GetEntityCoords(PlayerPedId()) - v) <= dis then  
        return true
    else 
        return false
    end
end

function drawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(7)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(255, 0, 0, 0, 255)
    SetTextEdge(255, 0, 0, 0, 255)
    SetTextDropShadow()
    if outline then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end