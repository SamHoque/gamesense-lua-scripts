local advancedHudMode = ui.new_combobox('LUA', 'A', 'Advanced HUD', 'OFF', 'Health Based', 'Looping');
local loopingDelay = ui.new_slider('LUA', 'A', 'Looping Delay', 0, 5000, 500, true, 'ms')
local currentHudColor = 0;
local nextLoop = 0;

local function setHudColor(i)
    client.exec('cl_hud_color ', i);
end

client.set_event_callback("paint", function()
    local health = entity.get_prop(entity.get_local_player(), "m_iHealth");
    local selectedMode = ui.get(advancedHudMode);
    if(selectedMode == 'Health Based') then
        setHudColor(health > 95 and 8 or health > 70 and 7 or health > 40 and 6 or 5);
    elseif(selectedMode == 'Looping') then
        if(nextLoop < globals.realtime()) then
            currentHudColor = currentHudColor + 1;
            setHudColor(currentHudColor);
            if(currentHudColor >= 10) then
                currentHudColor = 0;
            end
            local delay = ui.get(loopingDelay);
            nextLoop = globals.realtime() + delay / 1000;
        end
    end
end);