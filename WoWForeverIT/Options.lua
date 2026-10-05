-- Built lazily; /wfit opens the same panel on clients with differing Settings APIs.
local panel
local checks={}
function WoWForeverIT_OpenOptions()
    if not panel then
        panel=CreateFrame('Frame','WoWForeverITOptions',UIParent,'BasicFrameTemplateWithInset')
        panel:SetSize(490,355)
        panel:SetPoint('CENTER')
        panel:SetFrameStrata('DIALOG')
        panel:SetMovable(true)
        panel:EnableMouse(true)
        panel:RegisterForDrag('LeftButton')
        panel:SetScript('OnDragStart',panel.StartMoving)
        panel:SetScript('OnDragStop',panel.StopMovingOrSizing)
        panel.TitleText:SetText('WoWForeverIT — Opzioni')
        UISpecialFrames=UISpecialFrames or {}
        table.insert(UISpecialFrames,'WoWForeverITOptions')
        local rows={
            {'enabled','Abilita traduzioni'},
            {'quests','Missioni, registro e tracker'},
            {'questTooltips','Tooltip delle missioni'},
            {'interface','Interfaccia, menu, personaggio e professioni'},
            {'debug','Debug: mostra i testi originali in chat'},
        }
        for i,row in ipairs(rows) do
            local key=row[1]
            local check=CreateFrame('CheckButton',nil,panel,'UICheckButtonTemplate')
            check:SetPoint('TOPLEFT',18,-38-(i-1)*38)
            local caption=check:CreateFontString(nil,'OVERLAY','GameFontHighlight')
            caption:SetPoint('LEFT',check,'RIGHT',3,0)
            caption:SetText(row[2])
            check:SetScript('OnClick',function(self) WoWForeverIT_SetOption(key,self:GetChecked()) end)
            checks[key]=check
        end
        local note=panel:CreateFontString(nil,'OVERLAY','GameFontHighlightSmall')
        note:SetPoint('TOPLEFT',26,-244)
        note:SetWidth(435)
        note:SetJustifyH('LEFT')
        note:SetText('Le preferenze vengono salvate automaticamente.\n\nNomi di spell, oggetti e NPC: un controllo separato sarà disponibile quando avremo un database dedicato. I titoli delle quest seguono l’opzione Missioni.')
    end
    for key,check in pairs(checks) do check:SetChecked(WoWForeverIT_GetOption(key)) end
    panel:Show()
end

local minimapButton

local function positionMinimapButton()
    if not minimapButton or not Minimap then return end
    WoWForeverIT_Settings=WoWForeverIT_Settings or {}
    local angle=tonumber(WoWForeverIT_Settings.minimapAngle) or 220
    local radius=80
    local radians=math.rad(angle)
    minimapButton:ClearAllPoints()
    minimapButton:SetPoint('CENTER',Minimap,'CENTER',math.cos(radians)*radius,math.sin(radians)*radius)
end

local function saveMinimapButtonPosition()
    if not minimapButton or not Minimap then return end
    local mx,my=Minimap:GetCenter()
    local cx,cy=GetCursorPosition()
    local scale=UIParent:GetEffectiveScale()
    cx,cy=cx/scale,cy/scale
    local angle=math.deg(math.atan2(cy-my,cx-mx))
    WoWForeverIT_Settings=WoWForeverIT_Settings or {}
    WoWForeverIT_Settings.minimapAngle=angle
    positionMinimapButton()
end

local function createMinimapButton()
    if minimapButton or not Minimap then return end

    minimapButton=CreateFrame('Button','WoWForeverITMinimapButton',Minimap)
    minimapButton:SetSize(31,31)
    minimapButton:SetFrameStrata('MEDIUM')
    minimapButton:SetFrameLevel(Minimap:GetFrameLevel()+8)
    minimapButton:RegisterForClicks('LeftButtonUp')
    minimapButton:RegisterForDrag('LeftButton')
    minimapButton:SetMovable(true)
    minimapButton:EnableMouse(true)

    local background=minimapButton:CreateTexture(nil,'BACKGROUND')
    background:SetTexture('Interface\\Minimap\\UI-Minimap-Background')
    background:SetSize(20,20)
    background:SetPoint('TOPLEFT',7,-5)

    local icon=minimapButton:CreateTexture(nil,'ARTWORK')
    icon:SetTexture('Interface\\Icons\\INV_Misc_Book_09')
    icon:SetSize(17,17)
    icon:SetPoint('TOPLEFT',7,-6)
    icon:SetTexCoord(0.08,0.92,0.08,0.92)

    local border=minimapButton:CreateTexture(nil,'OVERLAY')
    border:SetTexture('Interface\\Minimap\\MiniMap-TrackingBorder')
    border:SetSize(53,53)
    border:SetPoint('TOPLEFT')

    local highlight=minimapButton:CreateTexture(nil,'HIGHLIGHT')
    highlight:SetTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight')
    highlight:SetBlendMode('ADD')
    highlight:SetSize(31,31)
    highlight:SetPoint('CENTER')

    minimapButton:SetScript('OnClick',function()
        if WoWForeverIT_OpenOptions then WoWForeverIT_OpenOptions() end
    end)
    minimapButton:SetScript('OnDragStart',function(self)
        self:SetScript('OnUpdate',saveMinimapButtonPosition)
    end)
    minimapButton:SetScript('OnDragStop',function(self)
        self:SetScript('OnUpdate',nil)
        saveMinimapButtonPosition()
    end)
    minimapButton:SetScript('OnEnter',function(self)
        GameTooltip:SetOwner(self,'ANCHOR_LEFT')
        GameTooltip:AddLine('WoW Forever IT',1,1,1)
        GameTooltip:AddLine('Clic: apri le opzioni',0.8,0.8,0.8)
        GameTooltip:AddLine('Trascina: sposta l’icona',0.8,0.8,0.8)
        GameTooltip:Show()
    end)
    minimapButton:SetScript('OnLeave',function()
        GameTooltip:Hide()
    end)

    positionMinimapButton()
end

local loader=CreateFrame('Frame')
loader:RegisterEvent('ADDON_LOADED')
loader:SetScript('OnEvent',function(self,_,name)
    if name~='WoWForeverIT' then return end
    createMinimapButton()
    self:UnregisterEvent('ADDON_LOADED')
end)
