ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getAccounts(data, xPlayer)
	local result = {}
	for i=1, #data do
		if(data[i] ~= 'money') then
			if(data[i] == 'black_money') and not Config.showBlackMoney then
				result[i] = nil
			else
				result[i] = xPlayer.getAccount(data[i])['money']
			end

		else
			result[i] = xPlayer.getMoney()
		end
	end
	return result
end

function tableIncludes(table, data)
	for _,v in pairs(table) do
		if v == data then
			return true
		end
	end
	return false
end

local allowedGrades = {
	'boss',
	'underboss'
}

RegisterServerEvent('lal_hud:retrieveData')
AddEventHandler('lal_hud:retrieveData', function()
	local m, b = nil
	TriggerEvent("core:GetMoney",function(_m,_b)
		m = _m
		b = _b
		print(m,b)
	end,source)

		local money,black_money = m,b

	  TriggerClientEvent('lal_hud:retrieveData', source, {cash = money, black_money = black_money})

end)

--[[
ESX.RegisterServerCallback('lal_hud:retrieveData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
		local money,bank,black_money = table.unpack(getAccounts({'money', 'bank', 'black_money'}, xPlayer))

		local society = nil
		if tableIncludes(allowedGrades, xPlayer.job.grade_name) then
			TriggerEvent('esx_society:getSociety', xPlayer.job.name, function(data)
				if data ~= nil then
					TriggerEvent('esx_addonaccount:getSharedAccount', data.account, function(account)
							society = account['money']
					end)
				end
			end)
		end
	  cb({cash = money, bank = bank, black_money = black_money, society = society})
	end
end)
]]--