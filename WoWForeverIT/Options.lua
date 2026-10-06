-- Built lazily; /wfit opens the same panel on clients with differing Settings APIs.
local panel
local checks={}
function WoWForeverIT_OpenOptions()
    if not panel then
        panel=CreateFrame('Frame','WoWForeverITOptions',UIParent,'BasicFrameTemplateWithInset')
        panel:SetSize(490,393)
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
        note:SetPoint('TOPLEFT',26,-282)
        note:SetWidth(435)
        note:SetJustifyH('LEFT')
        note:SetText('Le preferenze vengono salvate automaticamente.\n\nAbilità: mago e primo lotto delle altre otto classi; i testi non riconosciuti restano in inglese. Oggetti e NPC non sono ancora inclusi. I titoli delle quest seguono l’opzione Missioni.')
    end
    for key,check in pairs(checks) do check:SetChecked(WoWForeverIT_GetOption(key)) end
    panel:Show()
end
