local aimbotKey = ui.new_hotkey('LUA', 'A', 'Legit Bot Fix Key');
local legitBotDelayShot = ui.new_slider("LUA", "A", 'Missed Shots Reset', 1, 1000, 1, true, 'ms');
local timeToShoot = 0;

client.set_event_callback('setup_command', function(cmd)
    local entindex = entity.get_local_player()
    local active_weapon = entity.get_prop(entindex, "m_hActiveWeapon")
    if entindex == nil or not entity.is_alive(entindex) or active_weapon == nil then
        return
    end
    local item = bit.band((entity.get_prop(active_weapon, "m_iItemDefinitionIndex")), 0xFFFF);
    if(item ~= 9 and item ~= 40) then
        return
    end
    if(ui.get(aimbotKey)) then
        timeToShoot = globals.curtime()  + ui.get(legitBotDelayShot) / 1000;

        -- Disable attack
        cmd.in_attack = 0;
    end
    if(timeToShoot < globals.curtime() and timeToShoot ~= 0) then
        timeToShoot = 0;
        cmd.in_attack = 1;
    end
end)