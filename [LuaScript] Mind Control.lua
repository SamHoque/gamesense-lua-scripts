local player = ui.reference("players", "players", "player list")

ui.new_button("players", "players", "Steal Name", function()

    -- 226, 128, 139 is an ASCII Value that returns an invisible unicode
    client.set_cvar("name", string.char(226) .. string.char(128) .. string.char(139) .. entity.get_player_name(ui.get(player)))
end);

ui.new_button("players", "players", "CallVote Kick", function()
    local userid;

    -- Brute force the userid using entindex thanks @sapphyrus
    for i = 1, 20000 do
        if (client.userid_to_entindex(i) == ui.get(player)) then
            userid = i
            break;
        end
    end

    client.exec('callvote ', 'kick ', userid);
end);