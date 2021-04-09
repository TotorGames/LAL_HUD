
local lastJob = nil
local isAmmoboxShown = false
local PlayerData = nil
local jobName = "Chômage"
Citizen.CreateThread(function()

  Citizen.Wait(3000)

	SendNUIMessage({
		action = 'initGUI',
		data = { whiteMode = Config.enableWhiteBackgroundMode, enableAmmo = Config.enableAmmoBox, colorInvert = Config.disableIconColorInvert }
	})
end)


RegisterNetEvent('lal_hud:retrieveData')
AddEventHandler('lal_hud:retrieveData', function(data)
	SendNUIMessage({
		action = 'setMoney',
		cash = data.cash,
		black_money = data.black_money,
	})
end)

function showAlert(message, time, color)
	SendNUIMessage({
		action = 'showAlert',
		message = message,
		time = time,
		color = color
	})
end

RegisterNetEvent('lal_hud:showAlert')
AddEventHandler('lal_hud:showAlert', function(message, time, color)
	showAlert(message, time, color)
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		TriggerServerEvent('lal_hud:retrieveData')

	end
end)
AddEventHandler("es:activateJob",function(label)
	jobName = label
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
			
			if(lastJob ~= jobName) then
				
				lastJob = jobName
				SendNUIMessage({
					action = 'setJob',
					data = jobName
				})
			end
	
	end
end)
local jobName2 = "Citoyen"
local lastJob2 = nil
AddEventHandler("es:activateJob2",function(label)
	jobName2 = label
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		--	print(jobName2)
			if(lastJob2 ~= jobName2) then
				
				lastJob2 = jobName2
				if jobName2 == nil then
					jobName2 = "show"
				end
				SendNUIMessage({
					action = 'setJob2',
					data = jobName2
				})
			end
	
	end
end)

local isMenuPaused = false

function menuPaused()
	SendNUIMessage({
		action = 'disableHud',
		data = isMenuPaused
	})
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsPauseMenuActive() then
			if not isMenuPaused then
				isMenuPaused = true
				menuPaused()
			end
		elseif isMenuPaused then
			isMenuPaused = false
			menuPaused()
		end
		if IsControlJustPressed(1, 56) and GetLastInputMethod(0) then
			SendNUIMessage({
				action = 'showAdvanced'
			})
		end
	end
end)



AddEventHandler("ui:radio",function(bool)
	SendNUIMessage({
		action = 'setRadio',
		radio = bool
	})
end)

local oldState = false
AddEventHandler("ui:voice",function(bool)
	
	if bool == 0 or bool == false or bool == nil then
		bool = false
	else
		bool = true
	end
	if bool ~= oldState then
		SendNUIMessage({
			action = 'setVoice',
			voice = bool
		})
		oldState = bool
	end

end)

