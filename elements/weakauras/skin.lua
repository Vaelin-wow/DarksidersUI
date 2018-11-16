----------------------------------------------------------------------------------------
--	WeakAuras skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
    if not IsAddOnLoaded("WeakAuras") then return end

    local function Skin_WeakAuras(frame)
        -- if frame.icon then
        --     if frame.icon:GetNumPoints() > 0 then
        --         local point, relativeTo, relativePoint, xOfs, yOfs = frame.icon:GetPoint(1)
        --         frame.icon:SetPoint(point, relativeTo, relativePoint, -50, yOfs)
        --     end
		-- end

		if frame.bar then
            local point, relativeTo, relativePoint, xOfs, yOfs = frame.bar:GetPoint(1)
            frame.bar:SetPoint(point, relativeTo, relativePoint, 30, yOfs)
        end
        
    end
    for weakAura, _ in pairs(WeakAuras.regions) do
        -- print(WeakAuras.regions[weakAura].regionType)
        if WeakAuras.regions[weakAura].regionType == "aurabar" then
            -- WeakAuras.regions[weakAura].region:HookScript("OnInit", function(self)
            --     print('OKOKOK')
            --     Skin_WeakAuras(WeakAuras.regions[weakAura].region)
            -- end)
            WeakAuras.regions[weakAura].region:HookScript("OnShow", function(self)
                Skin_WeakAuras(WeakAuras.regions[weakAura].region)
            end)
            WeakAuras.regions[weakAura].region:HookScript("OnHide", function(self)
                Skin_WeakAuras(WeakAuras.regions[weakAura].region)
            end)
			-- Skin_WeakAuras(WeakAuras.regions[weakAura].region)
		end
    end
end)
