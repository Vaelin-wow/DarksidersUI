

	local _, ns = ...

	local Tools = {
		['Disenchant'] 	= {path = 'Trade_Engraving', id = 13262,  texture = [[Interface\ICONS\inv_enchant_disenchant]],},
		['Prospecting'] = {path = 'inv_misc_gem_01', id = 31252,  texture = [[Interface\ICONS\inv_misc_gem_bloodgem_01]],},
		['Fishing']		= {path = 'Trade_Fishing', 	 id = 131474, texture = [[Interface\ICONS\Trade_Fishing]],},
	}

	local bag = _G['dksdbag']

	for i = 1, 3 do 	--  cant parent to bag due to secure environment
		local bu  = CreateFrame('Button', 'dksdTool'..i, UIParent, 'SecureActionButtonTemplate')
		ns.BU(bu)
		ns.BUElements(bu)
		ns.DELEGATE_FRAMES_TO_POSITION[bu] = {'BOTTOMRIGHT', UIParent, i == 1 and -50 or i == 2 and -73 or -96, 61}
		ns.BDStone(bu, 5)
		bu:SetAttribute('type', 'spell')
		bu:SetFrameLevel(1)
		bu:SetAlpha(0)
		bu:EnableMouse(false)

		bu.t = bu:CreateTexture()
		bu.t:SetTexCoord(.1, .9, .1, .9)
		bu.t:SetAllPoints()

		bu.cd = CreateFrame('Cooldown', nil, bu, 'CooldownFrameTemplate')
		bu.cd:SetAllPoints()

		bu:SetScript('OnEnter', function()
			if  bu and bu.id then
				GameTooltip:SetOwner(bu, 'ANCHOR_CURSOR')
				GameTooltip:SetSpellByID(bu.id)
				GameTooltip:Show()
			end
		end)

		bu:SetScript('OnLeave', function() GameTooltip:Hide() end)
	end

	local OnShow = function()
		if _G['ContainerFrame1']:IsShown() then
			local index = 1
			local i = {GetProfessions()}

			for j = 1, 3  do							-- wipe
				local bu = _G['dksdTool'..j]
				bu:SetAlpha(0)
				bu:EnableMouse(false)
				bu.id = nil
			end

			for j = 1, #i do
				if i[j] then
					local _, ic = GetProfessionInfo(i[j])	-- by icon, name is local
					for n, v in pairs(Tools) do
						if strfind(ic, v.path) then
							local bu = _G['dksdTool'..index]
							bu:SetAttribute('spell', n)
							bu:EnableMouse(true)
							bu:SetAlpha(1)
							bu.t:SetTexture(v.texture)
							bu.id = v.id
							index = index + 1
						end
					end
				end
			end
		end
	end

	local OnClick = function()
		-- use the searchoverlay to highlight relevant items?
		-- this would use tooltip lookup probably, and would be expensive
	end

	local Hide = function()
		for i = 1, 3 do
			local bu = _G['dksdTool'..i]
			bu:SetAlpha(0)
			if not InCombatLockdown() then bu:EnableMouse(false) end
			bu.t:SetDesaturated(false)
			bu.id = nil
		end
	end

	local BAG_SHOW = function()
		if  InCombatLockdown() then
			Hide()
			dksd:RegisterEvent('PLAYER_REGEN_ENABLED', PLAYER_REGEN_ENABLED)
		else
			OnShow()
		end
	end

	local BAG_CLOSED = function()
		if  InCombatLockdown() then
			dksd:RegisterEvent('PLAYER_REGEN_ENABLED', PLAYER_REGEN_ENABLED)
		else
			Hide()
		end
	end

	local PLAYER_REGEN_ENABLED = function()
		OnShow()
		dksd:UnregisterEvent('PLAYER_REGEN_ENABLED', PLAYER_REGEN_ENABLED)
	end

	local TOOL_DISABLED = function()
		dksd:RegisterEvent('PLAYER_REGEN_ENABLED', PLAYER_REGEN_ENABLED)
		for i = 1, 3 do
			local bu = _G['dksdTool'..i]
			bu:EnableMouse(false) -- immediate
			bu.t:SetDesaturated(true)
			C_Timer.After(2, Hide)
		end
	end

	local SPELL_UPDATE_COOLDOWN = function()
		for i = 1, 3 do
			local bu = _G['dksdTool'..i]
			if  bu.id then
				local start, cd = GetSpellCooldown(bu.id)
				bu.cd:SetCooldown(start, cd)
			end
		end
	end

	bag:HookScript('OnShow', BAG_SHOW)
	bag:HookScript('OnHide', BAG_CLOSED)
	dksd:RegisterEvent('SPELL_UPDATE_COOLDOWN', SPELL_UPDATE_COOLDOWN)
	dksd:RegisterEvent('PLAYER_REGEN_DISABLED', TOOL_DISABLED)


	--
