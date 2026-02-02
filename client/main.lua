--[[
███████████████████████████████████████████████████████████████████████████████
█                                                                             █
█      ██╗     ██╗  ██╗██████╗        ██████╗██╗     ███████╗ █████╗ ███╗   █
█      ██║     ╚██╗██╔╝██╔══██╗      ██╔════╝██║     ██╔════╝██╔══██╗████╗  █
█      ██║      ╚███╔╝ ██████╔╝█████╗██║     ██║     █████╗  ███████║██╔██╗ █
█      ██║      ██╔██╗ ██╔══██╗╚════╝██║     ██║     ██╔══╝  ██╔══██║██║╚██╗█
█      ███████╗██╔╝ ██╗██║  ██║      ╚██████╗███████╗███████╗██║  ██║██║ ╚███
█      ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚══
█                                                                             █
███████████████████████████████████████████████████████████████████████████████

    🐺 WEAPON CLEANING SYSTEM - Client Logic
    
    Client-side weapon cleaning animations, camera control, and inspection
    UI for the immersive weapon maintenance system.
    
    For: The Land of Wolves - wolves.land
    By: iBoss21 / The Lux Empire
    
    Original: Le Bookmaker & Alphatule (RedEM:RP)
    VORP Rework: Darky_13
    LXR Conversion: iBoss21
    
    Copyright © 2026 The Lux Empire. All rights reserved.

███████████████████████████████████████████████████████████████████████████████
]]

-- ═════════════════════════════════════════════════════════════════════════
-- █████ LOCAL VARIABLES
-- ═════════════════════════════════════════════════════════════════════════

local IsInCameraMode = nil
local currentCamera = nil

-- ═════════════════════════════════════════════════════════════════════════
-- █████ WEAPON TYPE DETECTION
-- ═════════════════════════════════════════════════════════════════════════

local function GetWeaponType(weaponHash)
    -- Check if weapon is melee or knife
    if Citizen.InvokeNative(0x959383DCD42040DA, weaponHash) or 
       Citizen.InvokeNative(0x792E3EF76C911959, weaponHash) then
        return "MELEE"
    
    -- Check if weapon is sniper, rifle, or repeater
    elseif Citizen.InvokeNative(0x6AD66548840472E5, weaponHash) or 
           Citizen.InvokeNative(0x0A82317B7EBFC420, weaponHash) or 
           Citizen.InvokeNative(0xDDB2578E95EF7138, weaponHash) then
        return "LONGARM"
    
    -- Check if weapon is shotgun
    elseif Citizen.InvokeNative(0xC75386174ECE95D5, weaponHash) then
        return "SHOTGUN"
    
    -- Check if weapon is pistol or revolver
    elseif Citizen.InvokeNative(0xDDC64F5E31EEDAB6, weaponHash) or 
           Citizen.InvokeNative(0xC212F1D05A8232BB, weaponHash) then
        return "SHORTARM"
    
    else
        Framework.Notify(
            Language.translate[Config.Lang]['invalidWeapon'] or 'Error: This is not a valid weapon',
            'error',
            4000
        )
        return "ERROR"
    end
    
    return false
end

-- ═════════════════════════════════════════════════════════════════════════
-- █████ CAMERA MANAGEMENT
-- ═════════════════════════════════════════════════════════════════════════

local function EndCam()
    if Config.General.enableCamera then
        RenderScriptCams(false, true, 1000, true, false)
        if currentCamera then
            DestroyCam(currentCamera, false)
            currentCamera = nil
        end
        DisplayHud(true)
        DisplayRadar(true)
        DestroyAllCams(true)
    end
end

local function CreateCleaningCamera()
    if not Config.General.enableCamera then
        return nil
    end
    
    DestroyAllCams(true)
    local cam = CreateCameraWithParams(
        "DEFAULT_SCRIPTED_CAMERA",
        GetEntityCoords(PlayerPedId()),
        0.0, 0.0, 0.0,
        35.0,
        true,
        2
    )
    
    return cam
end

-- ═════════════════════════════════════════════════════════════════════════
-- █████ WEAPON CLEANING LOGIC
-- ═════════════════════════════════════════════════════════════════════════

local function StartWeaponCleaning()
    local ped = PlayerPedId()
    local weaponObject = GetCurrentPedWeaponEntityIndex(ped, 0)
    local _, weaponHash = GetCurrentPedWeapon(ped, true, 0, true)
    
    -- Check if player has a weapon equipped
    if weaponHash == `WEAPON_UNARMED` then
        Framework.Notify(
            Language.translate[Config.Lang]['noWeapon'] or 'You need to have a weapon equipped',
            'warning',
            4000
        )
        return
    end
    
    -- Get weapon type
    local weaponType = GetWeaponType(weaponHash)
    
    if weaponType == "ERROR" then
        return
    end
    
    -- Adjust weapon type for compatibility
    if weaponType == "SHOTGUN" then weaponType = "LONGARM" end
    if weaponType == "MELEE" then weaponType = "SHORTARM" end
    if weaponType == "BOW" then weaponType = "SHORTARM" end
    
    -- Close inventory if using VORP
    if Framework.Type == 'VORP' then
        TriggerEvent("vorp_inventory:CloseInv")
    end
    
    -- Create cleaning cloth prop
    local cloth = CreateObject(
        GetHashKey('s_balledragcloth01x'),
        GetEntityCoords(PlayerPedId()),
        false, true, false, false, true
    )
    
    local propId = GetHashKey("CLOTH")
    local object = GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(PlayerPedId(), 0))
    
    -- Start cleaning animation
    TaskItemInteraction_2(
        PlayerPedId(),
        weaponHash,
        cloth,
        propId,
        GetHashKey(weaponType .. "_CLEAN_ENTER"),
        1, 1, -1.0
    )
    
    -- Setup camera
    if Config.General.enableCamera then
        local cam = CreateCleaningCamera()
        
        Citizen.Wait(Config.General.cameraWaitTime)
        
        -- Attach camera to player and focus on weapon
        AttachCamToEntity(cam, PlayerPedId(), 0.65, 0.0, 1.15, true)
        PointCamAtEntity(cam, object, 0.0, 0.0, 0.0, true)
        RenderScriptCams(true, true, Config.General.cameraTransitionTime, true, true)
        
        Citizen.Wait(Config.General.cameraTransitionTime)
        
        IsInCameraMode = 1
        currentCamera = cam
    end
    
    -- Apply weapon maintenance
    if Config.WeaponMaintenance.resetDegradation then
        SetWeaponDegradation(object, 0.0, 0)
    end
    
    if Config.WeaponMaintenance.resetDirt then
        SetWeaponDirt(object, 0.0, 0)
    end
    
    if Config.Debug.printPlayerActions then
        print("^2[LXR-CleanGun]^7 Weapon cleaned successfully")
    end
end

-- ═════════════════════════════════════════════════════════════════════════
-- █████ WEAPON INSPECTION LOGIC
-- ═════════════════════════════════════════════════════════════════════════

local function ShowWeaponStats()
    if not Config.WeaponMaintenance.showStatsUI then
        return
    end
    
    local playerPed = PlayerPedId()
    local weaponObject = GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(playerPed, 0))
    local _, weaponHash = GetCurrentPedWeapon(playerPed, true, 0, true)
    
    -- Request and setup weapon inspection UI
    local block = RequestFlowBlock(GetHashKey("PM_FLOW_WEAPON_INSPECT"))
    local container = DatabindingAddDataContainerFromPath("", "ItemInspection")
    
    DatabindingAddDataBool(container, "Visible", true)
    DatabindingAddDataString(container, "tipText", GetLabelText(weaponObject))
    DatabindingAddDataHash(container, "itemLabel", weaponHash)
    
    Citizen.InvokeNative(0x10A93C057B6BD944, block)
    Citizen.InvokeNative(0x3B7519720C9DCB45, block, 0)
    Citizen.InvokeNative(0x4C6F2C4B7A03A266, -813354801, block)
    
    -- Monitor inspection state
    Citizen.CreateThread(function()
        Wait(1000)
        while true do
            Wait(100)
            if not Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) then
                Citizen.InvokeNative(0x4EB122210A90E2D8, -813354801)
                break
            end
        end
    end)
end

local function InspectWeapon()
    local ped = PlayerPedId()
    local weaponObject = GetCurrentPedWeaponEntityIndex(ped, 0)
    local _, weaponHash = GetCurrentPedWeapon(ped, true, 0, true)
    
    -- Check if player has a weapon equipped
    if weaponHash == `WEAPON_UNARMED` then
        return
    end
    
    -- Get weapon type
    local weaponType = GetWeaponType(weaponHash)
    
    if weaponType == "ERROR" then
        return
    end
    
    -- Adjust weapon type for compatibility
    if weaponType == "SHOTGUN" then weaponType = "LONGARM" end
    if weaponType == "MELEE" then weaponType = "SHORTARM" end
    if weaponType == "BOW" then weaponType = "SHORTARM" end
    
    -- Show weapon stats UI
    ShowWeaponStats()
    
    -- Start inspection animation
    TaskItemInteraction_2(
        PlayerPedId(),
        weaponHash,
        weaponObject,
        0,
        GetHashKey(weaponType .. "_HOLD_ENTER"),
        0, 0, -1.0
    )
end

-- ═════════════════════════════════════════════════════════════════════════
-- █████ KEY PRESS DETECTION
-- ═════════════════════════════════════════════════════════════════════════

local function WhenKeyJustPressed(key)
    return IsControlJustPressed(0, key)
end

local function WhenKeyJustReleased()
    -- E or Spacebar
    return IsControlJustReleased(0, Config.Keys.exitCamera1) or 
           IsControlJustReleased(0, Config.Keys.exitCamera2)
end

local function WhenKeyJustReleased2()
    -- F key
    return IsControlJustReleased(0, Config.Keys.exitCamera3)
end

-- ═════════════════════════════════════════════════════════════════════════
-- █████ MAIN THREAD (Key Detection & Camera Control)
-- ═════════════════════════════════════════════════════════════════════════

Citizen.CreateThread(function()
    while true do
        local sleep = Config.Performance.idleThreadSleep
        
        -- Check for inspection key press (Middle Mouse Button by default)
        if Config.General.enableInspection and WhenKeyJustPressed(Config.Keys.inspect) then
            sleep = Config.Performance.activeThreadSleep
            InspectWeapon()
        end
        
        -- Handle camera mode state machine
        if IsInCameraMode == 1 and WhenKeyJustReleased() then
            IsInCameraMode = 2
            sleep = Config.Performance.activeThreadSleep
            
        elseif IsInCameraMode == 2 and WhenKeyJustReleased2() then
            IsInCameraMode = 1
            sleep = Config.Performance.activeThreadSleep
            
        elseif IsInCameraMode == 1 and WhenKeyJustReleased2() then
            IsInCameraMode = nil
            EndCam()
            sleep = Config.Performance.idleThreadSleep
        end
        
        -- Optimize thread sleep
        if IsInCameraMode then
            sleep = Config.Performance.activeThreadSleep
        end
        
        Citizen.Wait(sleep)
    end
end)

-- ═════════════════════════════════════════════════════════════════════════
-- █████ NETWORK EVENTS
-- ═════════════════════════════════════════════════════════════════════════

-- Event triggered when using a cleaning item
RegisterNetEvent('lxr-cleangun:client:startCleaning')
AddEventHandler('lxr-cleangun:client:startCleaning', function()
    StartWeaponCleaning()
end)

-- Legacy VORP event support
RegisterNetEvent('cleaning:startcleaningshort')
AddEventHandler('cleaning:startcleaningshort', function()
    StartWeaponCleaning()
end)

-- Event triggered by /inspect command
RegisterNetEvent('lxr-cleangun:client:inspectWeapon')
AddEventHandler('lxr-cleangun:client:inspectWeapon', function()
    InspectWeapon()
end)

-- ═════════════════════════════════════════════════════════════════════════
-- █████ COMMAND REGISTRATION (Client-side)
-- ═════════════════════════════════════════════════════════════════════════

if Config.General.enableAdminCommands then
    -- Inspect command
    RegisterCommand('inspect', function(source, args, raw)
        InspectWeapon()
    end)
    
    -- Clean weapon command (triggers camera/animation, server validates)
    RegisterCommand('cleanweap', function(source, args, raw)
        StartWeaponCleaning()
    end)
end

-- ═════════════════════════════════════════════════════════════════════════
-- █████ RESOURCE CLEANUP
-- ═════════════════════════════════════════════════════════════════════════

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    
    -- Cleanup camera on resource stop
    if IsInCameraMode then
        EndCam()
        IsInCameraMode = nil
    end
end)
