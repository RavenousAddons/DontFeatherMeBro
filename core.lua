local ADDON_NAME, ns = ...

local unwantedBuffs = {
    [GetSpellInfo(44212)] = true, -- Jack-o'-Lanterned!
    [GetSpellInfo(61781)] = true, -- Turkey Feathers
}

function DontFeatherMeBro_OnLoad(self)
    self:RegisterUnitEvent("UNIT_AURA", "player")
end

function DontFeatherMeBro_OnEvent(self, event, arg, ...)
    if event == "UNIT_AURA" and arg == "player" then
        if not InCombatLockdown() then
            for i = 1, 40 do
                local name = UnitBuff("player", i)

                if not name then
                    return
                end

                if unwantedBuffs[name] then
                    CancelSpellByName(name)
                    DEFAULT_CHAT_FRAME:AddMessage("|cff" .. ns.color .. ns.name .. "|r |T136813:16|t " .. name .. " " .. ACTION_SPELL_AURA_REMOVED .. ".")
                end
            end
        end
    end
end
