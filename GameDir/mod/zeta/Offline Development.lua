local this = {
    modName = "Offline Development",
    modDesc =
    "This mod enables online-only items for offline development and changes development requirements to better match an offline mode playthrough",
    modCategory = { "Gameplay" },
    modAuthor = { "SugoiDogo" },
    modDisabledByDefault = false
}

local onlineOnly = 'p72'
local minutes = 'p71'
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
local OnlineMaxGMP = 25e6
local OfflineMaxGMP = 5e6
local GMPRatio = OfflineMaxGMP / OnlineMaxGMP
local OnlineMaxResources = 1e6
local OfflineMaxResources = 5e5
local ResourceRatio = OfflineMaxResources / OnlineMaxResources
local OnlineMaxPlants = 3e4
local OfflineMaxPlants = 6e3
local PlantsRatio = OfflineMaxPlants / OnlineMaxPlants
local MaxGrade = 15
local GMPPerGrade = OnlineMaxGMP / MaxGrade

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
    -- adjust development times for lack of online timers
    entry[minutes] = 5 * (entry[grade] - 1)
    -- calculate new gmp costs for any items that lack proper ones
    if entry[gmpUsage] > entry[gmp] then
        entry[gmp] = GMPPerGrade * entry[grade]
        entry[gmpUsage] = entry[gmp] / 100
    end
    -- reduce all costs by the ratio of online max to offline max
    entry[gmp] = entry[gmp] * GMPRatio
    entry[gmpUsage] = entry[gmpUsage] * GMPRatio
    if entry[resource1Type] and string.sub(entry[resource1Type], 1, 5) == 'Plant' then
        entry[resource1] = entry[resource1] * PlantsRatio
        entry[resource1Usage] = entry[resource1Usage] * PlantsRatio
    else
        entry[resource1] = entry[resource1] * ResourceRatio
        entry[resource1Usage] = entry[resource1Usage] * ResourceRatio
    end
    if entry[resource2Type] and string.sub(entry[resource2Type], 1, 5) == 'Plant' then
        entry[resource2] = entry[resource2] * PlantsRatio
        entry[resource2Usage] = entry[resource2Usage] * PlantsRatio
    else
        entry[resource2] = entry[resource2] * ResourceRatio
        entry[resource2Usage] = entry[resource2Usage] * ResourceRatio
    end
    -- enable all equipment offline
    entry[onlineOnly] = 0
end

return this
