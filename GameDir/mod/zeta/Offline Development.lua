local this = {
    modName = "Offline Development",
    modDesc =
    "This mod enables online-only items for offline development and changes development requirements to better match an offline mode playthrough",
    modCategory = { "Gameplay" },
    modAuthor = { "SugoiDogo" },
    modDisabledByDefault = false
}

local onlineOnly = 'p72'
local resource2Usage = 'p68'
local resource1Usage = 'p66'
local level2 = 'p64'
local resource2Type = 'p60'
local resource2 = 'p61'
local resource1Type = 'p58'
local resource1 = 'p59'
local level1 = 'p57'
local level = 'p55'
local gmpUsage = 'p54'
local gmp = 'p53'
local grade = 'p52'

function this.EquipDevelopFlowSettingEntry(entry)
    -- new level requirements max out at level 61 (100 S rank soldiers per unit)
    if entry[level] ~= 0 then
        entry[level] = 4 * (entry[grade] - 1) + 1
    end
    if entry[level1] ~= 0 then
        entry[level1] = 4 * (entry[grade] - 1) + 1
    end
    if entry[level2] ~= 0 then
        entry[level2] = 4 * (entry[grade] - 1) + 1
    end
    -- these are grade 1 cosmetic handguns, copy burkov costs
    if entry[gmp] == 0 and entry[gmpUsage] ~= 100 then
        entry[gmp] = 2e4
        entry[gmpUsage] = entry[gmp] / 100
    end
    -- these are online items, so give them high but reachable costs
    if entry[gmp] == 100 or entry[gmp] > 5e6 then
        entry[gmp] = 3e5 * entry[grade]
        entry[gmpUsage] = entry[gmp] / 100
        entry[resource1] = 2e3 * entry[grade]
        entry[resource1Usage] = entry[resource1] / 10
        entry[resource2] = 2e3 * entry[grade]
        entry[resource2Usage] = entry[resource2] / 10
    end
    -- keep plant costs under the game's offline maximum of 6k
    if entry[resource1Type] and string.sub(entry[resource1Type], 1, 5) == 'Plant' then
        entry[resource1] = 300 * entry[grade]
    end
    if entry[resource2Type] and string.sub(entry[resource2Type], 1, 5) == 'Plant' then
        entry[resource2] = 300 * entry[grade]
    end
    -- enable all equipment offline
    entry[onlineOnly] = 0
end

return this
