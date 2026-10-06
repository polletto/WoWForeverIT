-- Small launcher anchored outside the minimap; left click opens addon options.
local button
local function position(angle)
 local radians=math.rad(angle)
 local radius=math.min(Minimap:GetWidth(),Minimap:GetHeight())/2+8
 button:ClearAllPoints()
 button:SetPoint('CENTER',Minimap,'CENTER',math.cos(radians)*radius,math.sin(radians)*radius)
end
local function install()
 if button or not Minimap then return end
 button=CreateFrame('Button','WoWForeverITMinimapButton',Minimap)
 button:SetSize(32,32)
 WoWForeverIT_Settings=WoWForeverIT_Settings or {}
 position(tonumber(WoWForeverIT_Settings.minimapAngle) or 45)
 button:SetFrameStrata('MEDIUM')
 button:SetFrameLevel(Minimap:GetFrameLevel()+8)
 button:RegisterForClicks('LeftButtonUp')
 button:RegisterForDrag('LeftButton')
 button:SetScript('OnDragStart',function(self)
  self:SetScript('OnUpdate',function()
   local x,y=GetCursorPosition()
   local cx,cy=Minimap:GetCenter()
   if not cx or not cy then return end
   local scale=Minimap:GetEffectiveScale()
   local angle=math.deg(math.atan2(y/scale-cy,x/scale-cx))
   WoWForeverIT_Settings.minimapAngle=angle
   position(angle)
  end)
 end)
 button:SetScript('OnDragStop',function(self) self:SetScript('OnUpdate',nil) end)
 local icon=button:CreateTexture(nil,'ARTWORK')
 icon:SetPoint('CENTER')
 icon:SetSize(20,20)
 icon:SetTexture('Interface\\AddOns\\WoWForeverIT\\Media\\Icon.tga')
 local border=button:CreateTexture(nil,'OVERLAY')
 border:SetSize(54,54)
 border:SetPoint('TOPLEFT',button,'TOPLEFT',0,0)
 border:SetTexture('Interface\\Minimap\\MiniMap-TrackingBorder')
 button:SetHighlightTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight','ADD')
 button:SetScript('OnClick',function() WoWForeverIT_OpenOptions() end)
 button:SetScript('OnEnter',function(self)
  if not GameTooltip then return end
  GameTooltip:SetOwner(self,'ANCHOR_LEFT')
  GameTooltip:SetText('WoWForeverIT')
 GameTooltip:AddLine('Clic sinistro: apri le opzioni',1,1,1)
  GameTooltip:AddLine('Trascina: sposta lungo il bordo',1,1,1)
  GameTooltip:Show()
 end)
 button:SetScript('OnLeave',function() if GameTooltip then GameTooltip:Hide() end end)
end
local events=CreateFrame('Frame')
events:RegisterEvent('PLAYER_LOGIN')
events:RegisterEvent('PLAYER_ENTERING_WORLD')
events:SetScript('OnEvent',install)
