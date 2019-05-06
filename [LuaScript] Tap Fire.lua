local UI = {
    key = ui.new_hotkey("LUA", "A", "Tap Fire Key");
    delay = ui.new_slider("LUA", "A", 'Tap Fire Delay', 1, 100, 1, true, 's', 0.1);
}

local nextShot = 0;

client.set_event_callback('setup_command', function(cmd)
    if (ui.get(UI.key) and nextShot < globals.realtime()) then
        cmd.in_attack = 1;
        nextShot = globals.realtime() + ui.get(UI.delay) * 0.1;
    end
end);