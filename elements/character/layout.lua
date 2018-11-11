local PointGettingSet

local RemoveTextures = function(self, option)
    if((not self.GetNumRegions) or (self.Panel and (not self.Panel.CanBeRemoved))) then return end
    local region, layer, texture
    for i = 1, self:GetNumRegions()do
        region = select(i, self:GetRegions())
        if(region and (region:GetObjectType() == "Texture")) then

            layer = region:GetDrawLayer()
            texture = region:GetTexture()

            if(option) then
                if(type(option) == "boolean") then
                    if region.UnregisterAllEvents then
                        region:UnregisterAllEvents()
                        region:SetParent(_purgatory)
                    else
                        region.Show = region.Hide
                    end
                    region:Hide()
                elseif(type(option) == "string" and ((layer == option) or (texture ~= option))) then
                    region:SetTexture("")
                end
            else
                region:SetTexture("")
            end
        end
    end
end
local toggleCharacter = function(tab, onlyShow)
    -- TODO: update bag frame to a secure stack, or at least the currency icon
    -- if InCombatLockdown() then
    --     return
    -- end
    if (tab == 'PaperDollFrame') then
        CharacterFrame.bg:SetSize(676,666)
        CharacterFrame.bg:SetTexture[[Interface\AddOns\DarksidersUI\art\misc\CharacterFrame]]
        CharacterFrame.bg:SetPoint('TOPLEFT', CharacterFrame, -65,75)
    elseif (tab == 'ReputationFrame' or tab == 'TokenFrame') then
        CharacterFrame.bg:SetSize(676,666)
        CharacterFrame.bg:SetTexture[[Interface\AddOns\DarksidersUI\art\misc\ReputationFrame]]
        CharacterFrame.bg:SetPoint('TOPLEFT', CharacterFrame, -65,75)
        CharacterFrame:SetWidth(360)
        CharacterFrameInset:SetPoint('BOTTOMRIGHT', CharacterFrame, 'BOTTOMLEFT', 355, 4)
    end
end

local reSetPoint = function(self) 
    if PointGettingSet then return end
    PointGettingSet = true
    local point, relativeTo, relativePoint, xOfs, yOfs = CharacterFrame:GetPoint(1)
    CharacterWrapper:SetSize(CharacterFrame:GetWidth(), CharacterFrame:GetHeight())
    CharacterWrapper:SetPoint(point, UIParent, relativePoint, xOfs, yOfs)
    CharacterFrame:SetPoint('TOPLEFT', CharacterWrapper, 'TOPLEFT', 96, -30)
    PointGettingSet = false
end
local skinCharacterFrame = function()
    -- RemoveTextures(PaperDollSidebarTab1)
    -- RemoveTextures(PaperDollSidebarTab2)
    -- RemoveTextures(PaperDollSidebarTab3)

    CharacterFrame.bg = CharacterFrame:CreateTexture(nil, 'BACKGROUND', nil, -8)
    -- CharacterFrame.test = CharacterFrame:CreateTexture(nil, 'HIGH', nil, 7)
    -- CharacterFrame.test:SetSize(64,64)
    -- CharacterFrame.test:SetTexture[[Interface\AddOns\DarksidersUI\art\misc\Test]]
    -- CharacterFrame.test:SetPoint('CENTER', CharacterFrame, 0,0)
    RemoveTextures(CharacterStatsPane.ItemLevelCategory)
    CharacterStatsPane.ItemLevelCategory.bg = CharacterStatsPane.ItemLevelCategory:CreateTexture(nil, 'BACKGROUND', nil, -8)
    CharacterStatsPane.ItemLevelCategory.bg:SetSize(170,36)
    CharacterStatsPane.ItemLevelCategory.bg:SetTexture[[Interface\AddOns\DarksidersUI\art\misc\CharacterFrameCategory]]
    CharacterStatsPane.ItemLevelCategory.bg:SetPoint('CENTER', CharacterStatsPane.ItemLevelCategory, 0 ,-6)

    RemoveTextures(CharacterStatsPane.AttributesCategory)
    CharacterStatsPane.AttributesCategory.bg = CharacterStatsPane.AttributesCategory:CreateTexture(nil, 'BACKGROUND', nil, -8)
    CharacterStatsPane.AttributesCategory.bg:SetSize(170,36)
    CharacterStatsPane.AttributesCategory.bg:SetTexture[[Interface\AddOns\DarksidersUI\art\misc\CharacterFrameCategory]]
    CharacterStatsPane.AttributesCategory.bg:SetPoint('CENTER', CharacterStatsPane.AttributesCategory, 0 ,-6)

    RemoveTextures(CharacterStatsPane.EnhancementsCategory)
    CharacterStatsPane.EnhancementsCategory.bg = CharacterStatsPane.EnhancementsCategory:CreateTexture(nil, 'BACKGROUND', nil, -8)
    CharacterStatsPane.EnhancementsCategory.bg:SetSize(170,36)
    CharacterStatsPane.EnhancementsCategory.bg:SetTexture[[Interface\AddOns\DarksidersUI\art\misc\CharacterFrameCategory]]
    CharacterStatsPane.EnhancementsCategory.bg:SetPoint('CENTER', CharacterStatsPane.EnhancementsCategory, 0 ,-6)

    CharacterLevelText:Hide()
    -- CharacterFrameTitleText:Hide()
    CharacterFrameTitleText:SetPoint('TOP', 0, 10)
    CharacterFrameTitleText:SetFont("Fonts\\FRIZQT__.TTF", 16)
    CharacterFrameCloseButton:SetPoint('TOPRIGHT', CharacterFrame, 4, 18)

    local columnLeft = {
        "HeadSlot",
        "NeckSlot",
        "ShoulderSlot",
        "BackSlot",
        "ChestSlot",
        "ShirtSlot",
        "TabardSlot",
        "WristSlot",
        "SecondaryHandSlot"
    };
    for t,slotName in pairs(columnLeft) do
        local globalName = ("Character%s"):format(slotName)
        local charSlot = _G[globalName]
        if(charSlot) then
            if(not charSlot.Panel) then
            RemoveTextures(charSlot)
            charSlot.shadowBG = charSlot:CreateTexture(nil, 'OVERLAY', nil, 7)
            charSlot.shadowBG:SetSize(84,45)
            charSlot.shadowBG:SetTexture[[Interface\AddOns\DarksidersUI\art\misc\CharacterSlotBG_left]]
            
            charSlot.shadowBG:SetPoint('TOPLEFT', -4, 3)
            end
        end
    end
    local columnRight = {
        "HandsSlot",
        "WaistSlot",
        "LegsSlot",
        "FeetSlot",
        "Finger0Slot",
        "Finger1Slot",
        "Trinket0Slot",
        "Trinket1Slot",
        "MainHandSlot"
    };
    for t,slotName in pairs(columnRight) do
        local globalName = ("Character%s"):format(slotName)
        local charSlot = _G[globalName]
        if(charSlot) then
            if(not charSlot.Panel) then
            RemoveTextures(charSlot)
            charSlot.shadowBG = charSlot:CreateTexture(nil, 'OVERLAY', nil, 7)
            charSlot.shadowBG:SetSize(84,45)
            charSlot.shadowBG:SetTexture[[Interface\AddOns\DarksidersUI\art\misc\CharacterSlotBG_right]]
            charSlot.shadowBG:SetPoint('TOPLEFT', -4, 3)
            end
        end
    end
end
local OnEvent = function(self, event, ...)		--  fire on load, and then AGAIN when variables load in
    if event == 'PLAYER_ENTERING_WORLD' then
        
        local CharacterWrapper = CreateFrame("Frame", 'CharacterWrapper', UIParent)
        CharacterWrapper:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 0, 0)

        local CharFrameList = {
            "CharacterFrame",
            "CharacterModelFrame",
            "CharacterFrameInset",
            "CharacterStatsPane",
            "CharacterFrameInsetRight",
            "PaperDollFrame",
            "PaperDollSidebarTabs",
            "PaperDollEquipmentManagerPane"
        };

        for _,gName in pairs(CharFrameList) do
            if(_G[gName]) then RemoveTextures(_G[gName], true) else print(gName) end
        end

        skinCharacterFrame()

        hooksecurefunc("ToggleCharacter", toggleCharacter)
        hooksecurefunc(CharacterFrame, "SetPoint", reSetPoint)
    end
end

local init = CreateFrame'Frame'
init:RegisterEvent'PLAYER_ENTERING_WORLD'
init:SetScript('OnEvent', OnEvent)

-- TODO : SKIN MAIN MENU
    -- RemoveTextures(GameMenuFrame)
    -- RemoveTextures(GameMenuButtonMacros)
    -- local menuButtons = {
    --     GameMenuButtonHelp,
    --     GameMenuButtonStore,
    --     GameMenuButtonWhatsNew,
    --     GameMenuButtonOptions,
    --     GameMenuButtonUiOptions,
    --     GameMenuButtonKeybindings,
    --     GameMenuButtonMacros,
    --     GameMenuButtonAddons,
    --     GameMenuButtonLogout,
    --     GameMenuButtonQuit,
    --     GameMenuButtonContinue
    -- }
    -- for _, menuBtn in pairs(menuButtons) do
    --     RemoveTextures(menuBtn)
    -- end
