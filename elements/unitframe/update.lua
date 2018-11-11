

    local _, ns = ...

    local AddNameAnimation = function(Name, parent)
        local offset = -18

        Name.anim = Name:CreateAnimationGroup'SlidingFrame'

		Name.slideIn = Name.anim:CreateAnimation'Translation'
		Name.slideIn:SetDuration(.22)
		Name.slideIn:SetOffset(offset, 0)
		Name.slideIn:SetSmoothing'OUT'

		Name.slideIn:SetScript('OnPlay', function()
			Name:ClearAllPoints()
			Name:SetPoint('BOTTOMRIGHT', parent, 'TOPRIGHT', 20, 14)
	 	end)

		Name.slideIn:SetScript('OnFinished', function()
			active = false
			Name:ClearAllPoints()
			Name:SetPoint('BOTTOMRIGHT', parent, 'TOPRIGHT', 0, 14)
			Name.anim:Stop()
		end)

		Name.fadeIn = Name.anim:CreateAnimation'Alpha'
		Name.fadeIn:SetFromAlpha(0)
		Name.fadeIn:SetToAlpha(1)
	    Name.fadeIn:SetDuration(.5)
	    Name.fadeIn:SetSmoothing'OUT'
    end

    local PostUpdateName = function(self, event, unit)
        -- if not self.Name then return end

		-- if self.unit == unit then
		-- 	local r, g, b, t

        --     if unit == 'target' or unit == 'targettarget' then
        --         if  self.RaidTargetIndicator then
        --             self.RaidTargetIndicator:ClearAllPoints()
        --             self.RaidTargetIndicator:SetPoint('RIGHT', self.Name, -self.Name:GetStringWidth(), 2)
        --         end
        --     end

		-- 	if unit:sub(1, 4) == 'boss' or unit == 'focus' then
		-- 		r, g, b = 1, 1, 1
		-- 	elseif UnitIsTapDenied(unit) or not UnitIsConnected(unit) then
		-- 		r, g, b = .9, .9, .9
		-- 	elseif UnitIsPlayer(unit) then
		-- 		local _, class = UnitClass(unit)
		-- 		t = self.colors.class[class]
		-- 	else
		-- 		t = self.colors.reaction[UnitReaction(unit, 'player')]
		-- 	end

		-- 	if  t then r, g, b = t[1], t[2], t[3] end

		-- 	if r then
		-- 		self.Name:SetTextColor(r, g, b)
		-- 	end
		-- end
	end

    local PostUpdateHealth = function(Health, unit, v, max)
        -- local parent = Health:GetParent()

        -- if  UnitIsDead(unit) or UnitIsGhost(unit) then
		-- 	Health:SetValue(0)
		-- end

        -- if  unit == 'player' or unit == 'vehicle' then
        --     if  UnitInVehicle'player' or UnitControllingVehicle'player' then
        --         if parent.Portrait.vehicle then parent.Portrait.vehicle:Show() end
        --     else
        --         if parent.Portrait.vehicle then parent.Portrait.vehicle:Hide() end
        --     end
        -- end

        -- -- lightspark feedback solution
        -- local showBuilderFeedback = GetCVarBool'showBuilderFeedback'
	    -- local showSpenderFeedback = GetCVarBool'showSpenderFeedback'
	    -- if  max == 0 or v == 0 or v == max then
        --     --
        -- else
        --     local prev = Health.prev or 0
        --     local diff = v - prev

        --     if  diff > 0 then
        --         if  Health.Gain:GetAlpha() == 0 then
        --             local width     = Health:GetWidth()
        --             local offset    = width*(1 - prev/max)
        --             Health.Gain:SetAlpha(1)
        --             Health.Gain:SetPoint('TOPLEFT', Health, 'TOPRIGHT', -offset, 0)
        --             Health.Gain:SetPoint('BOTTOMLEFT', Health, 'BOTTOMRIGHT', -offset, 0)
        --             Health.Gain.FadeOut:Play()
        --         end
        --     elseif diff < 0 then
        --         Health.Gain.FadeOut:Stop()
        --         Health.Gain:SetAlpha(0)

        --         if  Health.Loss:GetAlpha() == 0 then
        --             local width     = Health:GetWidth()
        --             local offset    = width*(1 - prev/max)
        --             Health.Loss:SetAlpha(1)
        --             Health.Loss:SetPoint('TOPRIGHT', Health, 'TOPRIGHT', -offset, 0)
        --             Health.Loss:SetPoint('BOTTOMRIGHT', Health, 'BOTTOMRIGHT', -offset, 0)
        --             Health.Loss.FadeOut:Play()
        --         end
        --     end
        -- end

        -- if  Health.prev ~= v then
        --     Health.prev     = UnitHealth(unit)
        -- end

		-- return PostUpdateName(parent, 'PostUpdateHealth', unit)
    end

    local PostUpdatePower = function(Power, unit, v, min, max)
        -- local parent = Power:GetParent()
        -- local powerType, powerToken = UnitPowerType(unit)

        -- -- lightspark feedback solution
        -- local showBuilderFeedback = GetCVarBool'showBuilderFeedback'
	    -- local showSpenderFeedback = GetCVarBool'showSpenderFeedback'
	    -- if  max == 0 or v == 0 then
        --     --
        -- else
        --     local prev      = Power.prev or 0
        --     local diff      = v - prev

        --     if  Power.pulse then
        --         Power.pulse:Initialize(PowerBarColor[powerToken].fullPowerAnim)
        -- 		Power.pulse:SetMaxValue(UnitPowerMax(unit, powerType))
        --         if  Power.pulse and Power.pulse.active then
        --     		Power.pulse:StartAnimIfFull(prev, v)
        --         end
        --     end

        --     -- throttle small ticks
        --     if math.abs(diff) / max < .1 or v == max then
        --         diff = 0
        --     end

        --     if  diff > 0 then
        --         if  Power.Gain:GetAlpha() == 0 then
        --             local width     = Power:GetWidth()
        --             local offset    = width*(1 - prev/max)
        --             Power.Gain:SetPoint('TOPLEFT', Power, 'TOPRIGHT', -offset, 0)
        --             Power.Gain:SetPoint('BOTTOMLEFT', Power, 'BOTTOMRIGHT', -offset, 0)
        --             Power.Gain.FadeInOut:Play()
        --         end
        --     elseif diff < 0 then
        --         Power.Gain.FadeInOut:Stop()
        --         Power.Gain:SetAlpha(0)

        --         if  Power.Loss:GetAlpha() == 0 then
        --             local width     = Power:GetWidth()
        --             local offset    = width*(1 - prev/max)
        --             Power.Loss:SetPoint('TOPRIGHT', Power, 'TOPRIGHT', -offset, 0)
        --             Power.Loss:SetPoint('BOTTOMRIGHT', Power, 'BOTTOMRIGHT', -offset, 0)
        --             Power.Loss.FadeInOut:Play()
        --         end
        --     end
        -- end

        -- if  Power.prev ~= v then
        --     Power.prev = UnitPower(unit)
        -- end

        -- PostUpdateName(parent, 'PostUpdateHealth', unit)
    end

    local PostCastFade = function(Castbar, flag, successful)
        if  Castbar.timeToHold then
            UIFrameFadeOut(Castbar, Castbar.timeToHold, 1, 0)
        end
        if  not successful then
            Castbar:SetStatusBarColor(1, 0, 0)
            if  Castbar.text then Castbar.text:SetText('|cffec7878'..flag..'|r') end
        else
            Castbar:SetStatusBarColor(0, 1, 0)
        end
    end

    local PostCastInterrupted = function(Castbar, unit)
        if  unit == 'player' or unit == 'target' then
            PostCastFade(Castbar, INTERRUPTED)
        end
    end

    local PostCastFailed = function(Castbar, unit)
        if  unit == 'player' or unit == 'target' then
            PostCastFade(Castbar, FAILED)
        end
    end

    local PostCastStart = function(Castbar, unit, spell, spellrank)
        local parent = Castbar:GetParent()
        local t = (Castbar.notInterruptible and '|cff6200f4 |TInterface\\TargetingFrame\\Nameplates:18:18:0:-1:256:128:95:113:46:66|t' or '|cffff7200')..spell..'|r'

        if  unit == 'player' or unit == 'target' then
            ns.CLASS_COLOUR(Castbar)
            UIFrameFadeIn(Castbar, .05, 0, 1)
        end

        if  unit == 'target' then
            if  Castbar.notInterruptible then
                Castbar:SetStatusBarColor(.7, .7, .7)
            else
                if  Castbar.channeling then
                    Castbar:SetStatusBarColor(0,  1, 0)
                else
                    Castbar:SetStatusBarColor(1, .7, 0)
                end
            end
        end

		if  parent.Name then
            parent.Name:SetText(unit:sub(1, 4) == 'boss' and spell:gsub('(%u)%S*', '%1 ') or unit == 'target' and '' or UnitName(unit))
        end

        if  Castbar.text then
			Castbar.text:SetText((Castbar.notInterruptible and '|TInterface\\TargetingFrame\\Nameplates:18:18:0:-1:256:128:95:113:46:66|t' or '')..spell)
		end

        if  parent.Portrait and unit ~= 'player' then
            local _, _, texture = UnitCastingInfo(unit)
            if  texture then
                SetPortraitToTexture(parent.Portrait, texture)
            end
        end
    end

    local PostCastStop = function(Castbar, unit)
        local t
        local parent  = Castbar:GetParent()
		local Name    = parent.Name
        if  Name then
    		if  unit:sub(1, 4) == 'boss' or unit == 'targettarget' then
    			t = UnitName(unit) and UnitName(unit):gsub('(%u)%S* %l*%s*', '%1. ') or ''
    		else
    			t = UnitName(unit) or ''
    		end

    		Name:SetText(t)

    			-- sliding animation
    		local active = false
            if not Name.Anim then
                AddNameAnimation(Name, parent, active)
            end
    		if not active and unit == 'target' then
    			active = true
    			Name.anim:Play()
    		end
        end
        if  parent.Portrait and unit ~= 'player' then
            SetPortraitTexture(parent.Portrait, unit)
        end

        if unit == 'player' or unit == 'target' then
            PostCastFade(Castbar, nil, true)
        end
    end

    local PostCastStopUpdate = function(self, event, unit)
		if unit ~= self.unit then return end
		return PostCastStop(self.Castbar, unit)
    end

    local PostUpdatePortraitRing = function(self)
    	-- local classification  = UnitClassification(self.unit)
        -- if  self.unit == 'target' then
		-- 	local path            = 'Interface\\AddOns\\iipui\\art\\target\\'
		-- 	self.Portrait.Elite:Hide()
		-- 	if  classification == 'elite' or classification == 'worldboss' then
		-- 		self.Portrait.Elite:SetTexture(path..'elite')
		-- 		self.Portrait.Elite:Show()
		-- 	elseif classification == 'rareelite' or classification == 'rare' then
		-- 		self.Portrait.Elite:SetTexture(path..'r-elite')
        --     	self.Portrait.Elite:Show()
		-- 	end
		-- elseif  self.unit == 'targettarget' then
		-- 		if  classification == 'elite' or classification == 'worldboss' or classification == 'rareelite' or classification == 'rare' then
		-- 		self.Portrait.Elite:Show()
		-- 		if classification == 'rareelite' or classification == 'rare' then
		-- 				self.Portrait.Elite:SetDesaturated(true)
		-- 		else
		-- 				self.Portrait.Elite:SetDesaturated(false)
		-- 		end
		-- 	end
		-- end
	end

    ns.AddAuraElement = function(frame, unit, position, anchor, x, y, buffSize)
        -- TODO:  consider writing these as single buff/debuff elements?
        -- local BUFF_HEIGHT = if buff_height ~= nil then buff_height else 18 end
        local BUFF_HEIGHT = 20
		local BUFF_SPACING = 13
		local MAX_NUM_BUFFS = 10

		local Buffs = CreateFrame('Frame', nil, frame)
		Buffs:ClearAllPoints()
		Buffs:SetPoint(position[1], position[2], position[3], position[4], position[5])
		Buffs:SetWidth(BUFF_HEIGHT*MAX_NUM_BUFFS + BUFF_SPACING)
		Buffs:SetHeight(10)

		Buffs['initialAnchor'] = anchor
		Buffs['growth-x']	   = x
		Buffs['growth-y']	   = y
		Buffs['spacing-y']     = 10
		Buffs['spacing-x']     = 3
		Buffs['num']           = MAX_NUM_BUFFS
		Buffs['size']          = buffSize

		Buffs.disableCooldown  = false
		-- Buffs.onlyShowPlayer   = true

		-- Buffs.PostCreateIcon   = ns.PostCreateIcon
		-- Buffs.PostUpdateIcon   = ns.PostUpdateIcon
		-- Buffs.CustomFilter     = ns.CustomAuraFilter

        local Debuffs = CreateFrame('Frame', nil, frame)
		Debuffs:ClearAllPoints()
		Debuffs:SetPoint(position[1], position[2], position[3], position[4], position[5] - 130)
		Debuffs:SetWidth(200)
		Debuffs:SetHeight(30)

		Debuffs['initialAnchor'] = anchor
		Debuffs['growth-x']	   = x
		Debuffs['growth-y']	   = y
		Debuffs['spacing-y']     = 10
		Debuffs['spacing-x']     = 3
		Debuffs['num']           = 6
		Debuffs['size']          = 20

		Debuffs.disableCooldown  = false
		Debuffs.onlyShowPlayer   = true

		-- Debuffs.PostCreateIcon   = ns.PostCreateIcon
		-- Debuffs.PostUpdateIcon   = ns.PostUpdateIcon


		frame.Debuffs = Debuffs
		frame.Buffs = Buffs
	end

    ns.PreAndPostUpdatesForElements = function(self)
        local Health, Power, Castbar = self.Health, self.Power, self.Castbar
        Health.PostUpdate             = PostUpdateHealth
        Power.PostUpdate              = PostUpdatePower
		Castbar.PostChannelStart      = PostCastStart
		Castbar.PostCastStart         = PostCastStart
		Castbar.PostCastStop          = PostCastStop
		Castbar.PostChannelStop       = PostCastStop
        Castbar.PostCastInterrupted   = PostCastInterrupted
        Castbar.PostCastFailed        = PostCastInterrupted

        -- register update events
        self:RegisterEvent('UNIT_NAME_UPDATE', PostCastStopUpdate)
        table.insert(self.__elements, PostCastStopUpdate)
        --
        self:RegisterEvent('PLAYER_TARGET_CHANGED', PostUpdatePortraitRing)
        table.insert(self.__elements, PostUpdatePortraitRing)
    end


    --
