-- -- temporary gang funds solution
-- local cfg = module("cfg/gangfunds")
-- local gangfunds = cfg.gangfunds
-- local onesync = GetConvar('onesync', nil)

-- RegisterNetEvent('GMT:getGangFunds')
-- AddEventHandler('GMT:getGangFunds', function()
--     local source = source
--     local user_id = vRP.getUserId(source)
--     exports['ghmattimysql']:execute("SELECT * FROM gangfunds WHERE user_id = @user_id", {user_id = user_id}, function(result)
--         if result ~= nil then 
--             for k, v in pairs(result) do 
--                 if v.user_id == user_id then
--                     funds = v.funds 
--                     TriggerClientEvent("GMT:sendGangFunds", source, funds)
--                     return
--                 end
--             end
--             exports['ghmattimysql']:execute("INSERT INTO gangfunds (`user_id`, `funds`) VALUES (@user_id, @funds);", {user_id = user_id, funds = 0}, function() end) 
--         end
--     end)
-- end)

-- RegisterNetEvent('GangFunds:withdraw')
-- AddEventHandler('GangFunds:withdraw', function(amount)
--     local source = source
--     local user_id = vRP.getUserId(source)
--     if vRP.hasGroup(user_id, 'Gang') then
--         exports['ghmattimysql']:execute("SELECT * FROM gangfunds WHERE user_id = @user_id", {user_id = user_id}, function(result)
--             if result ~= nil then 
--                 for k, v in pairs(result) do 
--                     if v.user_id == user_id then
--                         funds = v.funds
--                         if funds >= amount then 
--                             newfunds = funds - amount
--                             exports['ghmattimysql']:execute("UPDATE gangfunds SET funds = @newfunds WHERE user_id = @user_id", {user_id = user_id, newfunds = newfunds}, function() end)
--                             vRPclient.notify(source, {'~g~Successfully withdrew £'..getMoneyStringFormatted(amount)..' from gang funds.'})
--                             vRP.giveMoney(user_id, amount)
--                             local webhook = 'https://discord.com/api/webhooks/984586811131191327/Zf1Fxf__xgUtFNCQpcysGwkIYzkI2AtshL-uRnrCaC-Vbom0tRaIQ5VWM2GQk2CW9oto'
--                             local embed = {
--                                 {
--                                     ["color"] = "16777215",
--                                     ["title"] = "Gang Funds",
--                                     ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User ID:** "..vRP.getUserId(source).."\n**Withdrew:** £"..getMoneyStringFormatted(amount),
--                                     ["footer"] = {
--                                         ["text"] = "GMT - "..os.date("%X"),
--                                     },
--                                 }
--                             }
--                             PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = 'GMT', embeds = embed}), { ['Content-Type'] = 'application/json' })
--                         else
--                             vRPclient.notify(source, {'~r~You do not have enough money in gang funds.'})   
--                         end
--                     end
--                 end
--             end
--         end)
--     else
--         vRPclient.notify(source, {'~r~You do not have Gang License.'})   
--     end
-- end)


-- RegisterNetEvent('GangFunds:deposit')
-- AddEventHandler('GangFunds:deposit', function(amount)
--     local source = source
--     local user_id = vRP.getUserId(source)
--     if vRP.hasGroup(user_id, 'Gang') then
--         exports['ghmattimysql']:execute("SELECT * FROM gangfunds WHERE user_id = @user_id", {user_id = user_id}, function(result)
--             if result ~= nil then 
--                 for k, v in pairs(result) do 
--                     if v.user_id == user_id then
--                         cash = vRP.getMoney(user_id)
--                         funds = v.funds
--                         if cash >= amount then 
--                             newfunds = funds+amount
--                             exports['ghmattimysql']:execute("UPDATE gangfunds SET funds = @newfunds WHERE user_id = @user_id", {user_id = user_id, newfunds = newfunds}, function() end)
--                             vRPclient.notify(source, {'~g~Successfully deposited £'..getMoneyStringFormatted(amount)..' into gang funds.'})
--                             vRP.setMoney(user_id,cash-amount)
--                             local webhook = 'https://discord.com/api/webhooks/984586811131191327/Zf1Fxf__xgUtFNCQpcysGwkIYzkI2AtshL-uRnrCaC-Vbom0tRaIQ5VWM2GQk2CW9oto'
--                             local embed = {
--                                 {
--                                     ["color"] = "16777215",
--                                     ["title"] = "Gang Funds",
--                                     ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User ID:** "..vRP.getUserId(source).."\n**Deposited:** £"..getMoneyStringFormatted(amount),
--                                     ["footer"] = {
--                                         ["text"] = "GMT - "..os.date("%X"),
--                                     },
--                                 }
--                             }
--                             PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = 'GMT', embeds = embed}), { ['Content-Type'] = 'application/json' })
--                         else
--                             vRPclient.notify(source, {'~r~You do not have enough money in cash.'})   
--                         end
--                     end
--                 end
--             end
--         end)
--     else
--         vRPclient.notify(source, {'~r~You do not have Gang License.'})   
--     end
-- end)

-- function getMoneyStringFormatted(cashString)
-- 	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
-- 	int = int:reverse():gsub("(%d%d%d)", "%1,")
-- 	return minus .. int:reverse():gsub("^,", "") .. fraction 
-- end


-- Citizen.CreateThread(function()
--     Wait(2500)
--     exports['ghmattimysql']:execute([[
--             CREATE TABLE IF NOT EXISTS `gangfunds` (
--                 `user_id` int(11) NOT NULL AUTO_INCREMENT,
--                 `funds` int(11) NOT NULL,
--                 PRIMARY KEY (`user_id`)
--               );
--         ]])
--     print("Gang Funds initialised")
-- end)