

	local _, ns = ...

	-- todo: reorient flyover buttons

	ns.bar_elements = {} --  inserted in buttons.lua
	wipe(ns.bar_elements)

	local e = CreateFrame'Frame'

	local bar = CreateFrame('Frame', 'dksdbar', UIParent)
	bar:SetHeight(150)
	bar:SetPoint('LEFT', 350, 0)
	bar:SetPoint('RIGHT', -350, 0)
	bar:SetPoint'BOTTOM'
	bar:SetFrameLevel(0)
	bar:SetFrameStrata'LOW'

	bar.collapse = CreateFrame('Frame', nil, bar)
	bar.collapse:SetHeight(100)
	bar.collapse:SetPoint'LEFT'
	bar.collapse:SetPoint'RIGHT'
	bar.collapse:SetPoint('TOP', bar, 'BOTTOM', 0, 42)

	-- bar.t = bar.collapse:CreateTexture(nil, 'BACKGROUND')
	-- bar.t:SetSize(310, 20)
	-- bar.t:SetPoint'TOP'
	-- bar.t:SetTexture[[Interface\QUESTFRAME\AutoQuest-Parts]]
	-- bar.t:SetTexCoord(.44, .9, 0, .5)
	-- bar.t:SetAlpha(.65)
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
	local ToggleButtons = function(show)
		if  HasExtraActionBar() then
			local bar = ExtraActionBarFrame
			local cd  = _G['ExtraActionButton1Cooldown']
			cd:SetDrawBling(show)
			bar:SetAlpha(show and 1 or 0)
		end
		for i = 1, 12 do
			for _, v in pairs(
				{
					'ActionButton',
					'MultiBarBottomLeftButton',
					'MultiBarBottomRightButton',
					'MultiBarLeftButton',
					'MultiBarRightButton',
					'StanceButton',
					'PetActionButton',
				}
			) do
				local bu = _G[v..i]
				if  bu and bu:IsShown() then
					bu.cooldown:SetDrawBling(show)
					bu:SetAlpha(show and 1 or 0)
				end
			end
		end
	end

	local ToggleFrames = function(show)
		if 	show then
			-- MainMenuBarPageNumber:Show()
		else
			-- MainMenuBarPageNumber:Hide()
		end
		for _, v in pairs(ns.bar_elements) do
			local n = v:GetName()
			if 	n == nil or not n:match'ActionButton(.+)' then
				v:SetAlpha(show and 1 or 0)
			end
		end
	end

	local ToggleBars = function(show)
		for i = 1, 7 do
			local f = _G['dksdaction'..i]
			if  f and f:GetBackdrop() then
				f:SetBackdropColor(0, 0, 0, show and 1 or 0)
			end
		end
	end

	local UpdateElements = function(show)
		ToggleButtons(show)
		ToggleFrames(show)
		ToggleBars(show)
		bar.shown = show
	end

	local grow = function(self)
		local x = {bar.collapse:GetPoint()}
		local z =  bar:GetHeight()/4
		if 	x[5] < z then
			bar.collapse:SetPoint('TOP', bar, 'BOTTOM', 0, x[5] + 11)
			UpdateElements(x[5] > (bar:GetHeight()/4 - 20) and true or false)
		else
			self:SetScript('OnUpdate', nil)
		end
	end

	local shrink = function(self)
		local x = {bar.collapse:GetPoint()}
		local z =  bar:GetHeight()/4
		if 	x[5] > 4 and not InCombatLockdown() then
			bar.collapse:SetPoint('TOP', bar, 'BOTTOM', 0, x[5] - 11)
			UpdateElements(x[5] > (bar:GetHeight()/4 - 20) and true or false)
		else
			self:SetScript('OnUpdate', nil)
		end
	end

	local OnEnter = function()
		-- if UnitExists("target") and not UnitIsFriend("player", "target") then 
			local startAlpha = bar:GetAlpha()
			if startAlpha == 1 then return end
			UIFrameFadeIn(bar, 0.2, startAlpha, 1)
		-- end
		-- bar:SetScript('OnUpdate', grow)
	end

	local OnLeave = function()
		local isArena, isRegistered = IsActiveBattlefieldArena()
		local inBG = UnitInBattleground("player")
		local inLockdown = InCombatLockdown()
		-- 
		if ns.bar_always or ns.bar_spellbook or isArena or inLockdown or inBG ~= nil then return end
		local startAlpha = bar:GetAlpha()
		if startAlpha == 0 then return end
		UIFrameFadeOut(bar, 0.2, startAlpha, 0)
		-- bar:SetScript('OnUpdate', shrink)
	end

	local OnShow = function()
		ns.bar_spellbook = true
		OnEnter()
	end

	local OnHide = function()
		ns.bar_spellbook = false
		OnLeave()
	end

	local OnLock = function()
		if  dksdAlwaysActionBar == 1 then
			e:UnregisterAllEvents()
			e:SetScript('OnEvent', nil)
			ns.bar_always = true
			OnEnter()
		else
			ns.bar_always = false
			OnLeave()
		end
	end

	local OnCombat = function()
		-- print(dksdCombatActionBar)
		-- if  dksdCombatActionBar == 1 then
		e:RegisterEvent'PLAYER_REGEN_DISABLED'
		e:RegisterEvent'PLAYER_REGEN_ENABLED'
		e:SetScript('OnEvent', function(self, event, ...)
			if event == 'PLAYER_REGEN_DISABLED' then
				OnEnter()
			else
				OnLeave()
			end
		end)
		-- else
		-- 	e:UnregisterEvent'PLAYER_REGEN_DISABLED'
		-- 	e:UnregisterEvent'PLAYER_REGEN_ENABLED'
		-- 	e:SetScript('OnEvent', nil)
		-- end
	end

	ns.AddBarLocks = function()
		OnCombat()
		OnLock()
	end

	ns.AddBarMouseoverElements = function()				-- assert "sticky" behaviour for bar pseudo-children
		ns.AddBarLocks()						-- preventing the bar collapsing when we mouseover elements within
		for i, v in pairs(ns.bar_elements) do	-- this is run on the initial login OnUpdate collapse
												-- in order to collect elements added after this file is run
			if not v.RegisteredForBar then		-- kill overhead
				v:HookScript('OnEnter', OnEnter)
				v:HookScript('OnLeave', OnLeave)
				v.RegisteredForBar = true
			end
		end
						  						-- defined in customise/customise.lua
		-- for  _, v in pairs(ns.bar_elements_custom) do
		-- 	if 	v and not ns.bar_elements[v] then
		-- 		tinsert(ns.bar_elements, v)
		-- 	end
		-- end
	end

	dksdBarToggle = function()					-- global for keybind
		if  not bar.elementsShown then
			ns.bar_always = true
			OnEnter()
		else
			ns.bar_always = false
			OnLeave()
		end
	end

	local OnTargetChanged = function (self, event)
		if UnitCanAttack("player", "target") == true then
			ns.bar_always = true
			OnEnter()
		else
			ns.bar_always = false
			OnLeave()
		end
	end
	local function DisableBlizzard()
		-- Hidden parent frame
		UIHider = CreateFrame("Frame")
		UIHider:Hide()
	end
	local OnEvent = function(self, event, ...)		--  fire on load, and then AGAIN when variables load in
		if event == 'PLAYER_ENTERING_WORLD' then
			OnLeave()
			ns.AddBarLocks()
			local t = CreateFrame'Frame'
			t:RegisterEvent'PLAYER_TARGET_CHANGED'
			t:SetScript('OnEvent', OnTargetChanged)
			IconIntroTracker:UnregisterAllEvents()
			IconIntroTracker:Hide()
			IconIntroTracker:SetParent(UIHider)

			MainMenuBarArtFrameBackground:Hide()
			MainMenuBarArtFrame.RightEndCap:Hide()
			MainMenuBarArtFrame.LeftEndCap:Hide()
			-- MainMenuBarArtFrame:SetParent(UIHider)
		elseif event == 'MODIFIER_STATE_CHANGED' then
			local mod, status = ...
			if (mod == 'LCTRL') then 
				if (status == 0) then
					OnHide()
				else 
					OnShow()
				end
			end
		end
	end

	ns.grow 	= OnEnter
	ns.shrink 	= OnLeave
	SpellBookFrame:HookScript('OnShow', OnShow)
	SpellBookFrame:HookScript('OnHide', OnHide)

	local init = CreateFrame'Frame'
	init:RegisterEvent'PLAYER_ENTERING_WORLD'
	init:RegisterEvent'VARIABLES_LOADED'
	init:RegisterEvent'MODIFIER_STATE_CHANGED'
	init:SetScript('OnEvent', OnEvent)

	
	--
