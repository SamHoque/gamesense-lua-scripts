local names = {};
local cache = { curName = 1, nextChange = 0, infinite = false };
local nameStealer = ui.new_combobox('LUA', 'A', 'Name Stealer', 'OFF', 'Everyone', 'Enemies Only', 'Teammates Only');

local function updateNames()
    local ret = {}
    local lp = entity.get_local_player();
    for i = globals.maxplayers(), 1, -1 do
        i = math.floor(i);
        local name = entity.get_player_name(i)
        if (name ~= 'unknown' and i ~= lp) then
            local nameStealerMode = ui.get(nameStealer);
            local lpTeam = entity.get_prop(lp, "m_iTeamNum");
            local otherTeam = entity.get_prop(i, "m_iTeamNum");
            if(nameStealerMode == "Everyone" or (lpTeam ~= otherTeam and nameStealerMode == 'Enemies Only') or (lpTeam == otherTeam and nameStealerMode == 'Teammates Only')) then
                table.insert(ret, name);
            end
        end
    end
    names = ret
end

client.set_event_callback("paint", function()
    if (ui.get(nameStealer) == "OFF") then
        return
    end
    updateNames();
    if (cache.infinite == false) then
        -- Infinite name 'borrowed' from @duk
        client.set_cvar("name", "\n\xAD\xAD\xAD\xAD");
        cache.infinite = true;
        cache.nextChange = globals.realtime() + 2;
    end
    if (cache.nextChange < globals.realtime()) then
        if (cache.curName > #names) then
            cache.curName = 1;
        end
        client.set_cvar("name", "\xE2\x80\x8B" .. names[cache.curName])
        cache.curName = cache.curName + 1
        cache. nextChange = globals.realtime() + 0.5;
    end
end)