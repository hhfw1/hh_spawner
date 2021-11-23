local Cam, Cam2 = nil, nil
-- Code

RegisterNetEvent('hh-spawn:client:choose:spawn')
AddEventHandler('hh-spawn:client:choose:spawn', function()
    Citizen.SetTimeout(450, function()
        local PlayerData = QBCore.Functions.GetPlayerData()
        local InJail = false
        SetEntityVisible(PlayerPedId(), false)
        DoScreenFadeOut(250)
        Citizen.Wait(2000)
        DoScreenFadeIn(250)
        SetSkyCam(true)
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'spawn',
            injail = InJail,
        })
    end)
end)

RegisterNetEvent('hh-spawn:client:choose:appartment')
AddEventHandler('hh-spawn:client:choose:appartment', function()
    SetEntityVisible(PlayerPedId(), false)
    DoScreenFadeOut(250)
    Citizen.Wait(2000)
    DoScreenFadeIn(250)
    SetSkyCam(true)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'new',
    })
end)

RegisterNUICallback('SpawnPlayer', function(data)
    Citizen.Wait(2000)
    SpawnPlayer(data.SpawnId)
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
end)

RegisterNUICallback('ChooseAppartment', function(data)
    DoScreenFadeOut(250)
    Citizen.Wait(100)
    SetSkyCam(false)
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    TriggerServerEvent('apartments:server:CreateApartment', data.AppId)
end)

RegisterNUICallback('SpawnJail', function(data)
    DoScreenFadeOut(250)
    Citizen.Wait(100)
    SetSkyCam(false)
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    Citizen.Wait(100)
    TriggerEvent('prison:client:spawn:prison')
end)

RegisterNUICallback('Close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('Click', function()
    PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
end)

function SetSkyCam(bool)
  if bool then
        Cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -265.51, -811.01, 31.85 + 300, -85.00, 0.00, 0.00, 100.00, false, 0)
        SetCamActive(Cam, true)
        SetFocusArea(-265.51, -811.01, 31.85 + 175, 0.0, 0.0, 0.0)
        ShakeCam(Cam, "HAND_SHAKE", 0.15)
        SetEntityVisible(PlayerPedId(), false)
        RenderScriptCams(true, false, 3000, 1, 1)
  else
      if DoesCamExist(Cam) then
        RenderScriptCams(false, true, 500, true, true)
        SetCamActive(Cam, false)
        DestroyCam(Cam, true)
      end
      SetFocusEntity(PlayerPedId())
      FreezeEntityPosition(PlayerPedId(), false)
      SetEntityVisible(PlayerPedId(), true)
  end
end

function SpawnPlayer(SpawnId)
    if SpawnId == 'lastlocation' then
        QBCore.Functions.GetPlayerData(function(PlayerData)
          SetEntityCoords(PlayerPedId(), PlayerData.position.x, PlayerData.position.y, PlayerData.position.z - 0.9, 0, 0, 0, false)
          SetFocusArea(PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + 300, 0.0, 0.0, 0.0)
          SetCamParams(Cam, PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + 300, -85.0, 0.00, 0.00, 100.0, 7200, 0, 0, 2)
          Citizen.Wait(6500)
          SetFocusArea(PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + 10, 0.0, 0.0, 0.0)
          SetCamParams(Cam, PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + 10, -40.0, 0.00, 0.00, 100.0, 5000, 0, 0, 2)
          Citizen.Wait(4500)
          Citizen.SetTimeout(1000, function()
             SetSkyCam(false)
             Citizen.Wait(100)
             DoScreenFadeOut(250)
             Citizen.Wait(150)
             SetSkyCam(false)
             Citizen.Wait(1000)
             DoScreenFadeIn(1000)
          end)
        end)
    else
        SetFocusArea(Config.Locations[SpawnId]['Coords']['X'], Config.Locations[SpawnId]['Coords']['Y'], Config.Locations[SpawnId]['Coords']['Z'] + Config.Locations[SpawnId]['Coords']['Z-Offset'], 0.0, 0.0, 0.0)
        SetCamParams(Cam, Config.Locations[SpawnId]['Coords']['X'], Config.Locations[SpawnId]['Coords']['Y'], Config.Locations[SpawnId]['Coords']['Z'] + Config.Locations[SpawnId]['Coords']['Z-Offset'], Config.Locations[SpawnId]['Coords']['XR'], 0.00, 0.00, 100.0, 7200, 0, 0, 2)
        SetEntityCoords(PlayerPedId(), Config.Locations[SpawnId]['Coords']['X'], Config.Locations[SpawnId]['Coords']['Y'], Config.Locations[SpawnId]['Coords']['Z'] - 0.9, 0, 0, 0, false)
        SetEntityHeading(PlayerPedId(), Config.Locations[SpawnId]['Coords']['H'])
        Citizen.Wait(6500)
        if SpawnId == 'spawn4' or SpawnId == 'spawn5' then
            SetFocusArea(Config.Locations[SpawnId]['Coords']['X'], Config.Locations[SpawnId]['Coords']['Y'], Config.Locations[SpawnId]['Coords']['Z'] + 10, 0.0, 0.0, 0.0)
            SetCamParams(Cam, Config.Locations[SpawnId]['Coords']['X'], Config.Locations[SpawnId]['Coords']['Y'], Config.Locations[SpawnId]['Coords']['Z'] + 10, -40.0, 0.00, 0.00, 100.0, 5000, 0, 0, 2)
          Citizen.Wait(4500)
        end
        Citizen.SetTimeout(1000, function()
           SetSkyCam(false)
           Citizen.Wait(100)
           DoScreenFadeOut(250)
           Citizen.Wait(150)
           SetSkyCam(false)
           Citizen.Wait(1000)
           DoScreenFadeIn(1000)
        end)
    end
end