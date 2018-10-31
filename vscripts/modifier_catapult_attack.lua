modifier_catapult_attack=class({})

function modifier_catapult_attack:DeclareFunctions()
	local funcs={
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACK,
	}
	return funcs
end

function modifier_catapult_attack:OnRefresh( kv )
	self.bonus_damage=self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.duration=self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_catapult_attack:OnAttack(kv)
	if kv.attacker==self:GetCaster() then
		self:DecrementStackCount()
	end
end


function modifier_catapult_attack:OnCreated( kv )
	self:SetStackCount(5)
	self.bonus_damage=self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.duration=self:GetAbility():GetSpecialValueFor("duration")

	

end

function modifier_catapult_attack:GetModifierDamageOutgoing_Percentage( params )
	if self:GetStackCount()>0 then
		return self.bonus_damage
	else
		self:GetCaster():RemoveModifierByName("modifier_catapult_attack")
		return	0
	end
end

function modifier_catapult_attack:GetModifierMoveSpeedBonus_Percentage(params)
	return 100
end