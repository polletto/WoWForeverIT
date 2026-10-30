-- Built lazily; /wfit opens the same panel on clients with differing Settings APIs.
local panel
local checks={}
function WoWForeverIT_OpenOptions()
    if not panel then
        panel=CreateFrame('Frame','WoWForeverITOptions',UIParent,'BasicFrameTemplateWithInset')
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
            {'spells','Magie: nomi e descrizioni supportate'},
            {'items','Oggetti: nomi e tooltip supportati'},
            {'creatures','Creature: tooltip e nameplate'},
            {'minimap','Pulsante sulla minimappa (/wfit riapre sempre le opzioni)'},
            {'capture','Raccogli i testi inglesi non tradotti (/wfit cattura)'},
            {'debug','Debug: mostra i testi originali in chat'},
        }
        panel:SetSize(490,48+#rows*38+150)
        local lastCheck
        for i,row in ipairs(rows) do
            local key=row[1]
            local check=CreateFrame('CheckButton',nil,panel,'UICheckButtonTemplate')
            check:SetPoint('TOPLEFT',18,-38-(i-1)*38)
            local caption=check:CreateFontString(nil,'OVERLAY','GameFontHighlight')
            caption:SetPoint('LEFT',check,'RIGHT',3,0)
            caption:SetText(row[2])
            check.caption=caption
            check:SetScript('OnClick',function(self) WoWForeverIT_SetOption(key,self:GetChecked()) end)
            checks[key]=check
            lastCheck=check
        end
        local note=panel:CreateFontString(nil,'OVERLAY','GameFontHighlightSmall')
        note:SetPoint('TOPLEFT',lastCheck,'BOTTOMLEFT',8,-18)
        note:SetWidth(435)
        note:SetJustifyH('LEFT')
        note:SetText('Le preferenze vengono salvate automaticamente.\n\nLa copertura di abilità, oggetti e creature è parziale: i testi non riconosciuti restano in inglese. I nomi dei giocatori non vengono modificati. I titoli delle quest seguono l’opzione Missioni.\n\nMolte traduzioni delle quest vengono da QuestIT (Drakanast), con l’aiuto della comunità Discord di QuestIT. #italyforazeroth https://italy-for-azeroth.vercel.app/')
    end
    WoWForeverIT_RefreshOptions()
    panel:Show()
end
-- Translation switches are greyed out while translations are off;
-- debug, capture and the minimap button stay usable.
local independent={enabled=true,minimap=true,capture=true,debug=true}
function WoWForeverIT_RefreshOptions()
    local on=WoWForeverIT_GetOption('enabled')
    for key,check in pairs(checks) do
        check:SetChecked(WoWForeverIT_GetOption(key))
        local usable=independent[key] or on
        if type(check.SetEnabled)=='function' then check:SetEnabled(usable)
        elseif usable and type(check.Enable)=='function' then check:Enable()
        elseif type(check.Disable)=='function' then check:Disable() end
        if check.caption and type(check.caption.SetTextColor)=='function' then
            if usable then check.caption:SetTextColor(1,1,1) else check.caption:SetTextColor(0.5,0.5,0.5) end
        end
    end
end
