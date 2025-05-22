local this={
	modName = "Offline Development",
	modDesc = "This mod enables online-only items for offline development and changes development requirements to better match an offline mode playthrough",
	modCategory = {"Gameplay"},
	modAuthor = {"SugoiDogo"},
	modDisabledByDefault = false
}

local onlineOnly='p72'
local minutes='p71'
local resource2Usage='p68'
local resource1Usage='p66'
local level2='p64'
local resource2='p61'
local resource1='p59'
local level1='p57'
local level='p55'
local gmpUsage='p54'
local gmp='p53'
local grade='p52'

function this.EquipDevelopFlowSettingEntry(entry)
    -- enable all equipment offline
    entry[onlineOnly]=0
    -- new level requirements max out at level 61 (100 S rank soldiers per unit)
    entry[level]=4*(entry[grade]-1)+1
    entry[level1]=4*(entry[grade]-1)+1
    entry[level2]=4*(entry[grade]-1)+1
    -- these are grade 1 cosmetic handguns, copy burkov costs
    if entry[gmp] == 0 and entry[gmpUsage] ~= 100 then
        entry[gmp]=2e4
        entry[gmpUsage]=entry[gmp]/100
    end
    -- these are online items, so give them high but reachable costs
    if entry[gmp] == 100 or entry[gmp] > 5e6 then
        entry[gmp]=3e5*entry[grade]
        entry[gmpUsage]=entry[gmp]/100
        entry[resource1]=2e3*entry[grade]
        entry[resource1Usage]=entry[resource1]/10
        entry[resource2]=2e3*entry[grade]
        entry[resource2Usage]=entry[resource2]/10
    end
end

return this