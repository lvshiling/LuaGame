require("Class")

--引用UnityEngine.Time
local Time = UnityEngine.Time

SkillChange = Class()
function SkillChange:ctor(varSkillType, varEndAt, varBeginAt, varSpeed,  varFadeLength)
    self.mSkillType = varSkillType
    self.mEndAt = varEndAt
    self.mBeginAt = varBeginAt
    self.mSpeed  = varSpeed
    self.mFadeLength  = varFadeLength
end

SkillCancel = Class()
function SkillCancel:ctor(varSkillType, varBefore, varFadeLegnth)
    self.mSkillType = varSkillType
    self.mBefore = varBefore
    self.mFadeLength =varFadeLegnth
end

--技能状态
PlayerSkillState = Class(State)

function PlayerSkillState:ctor(name)
    self.mPlayerSkillType = "None"
    self.mCacheSkillState = nil
    self.mChangeList = {}
    self.mCancelList = {}
    self.mSkillPluginList = {}

    self.mSpeed = 1
    self.mChangeAt = 0
    self.mFadeLength = 0
    self.mChanging = false 

	self.mChangeAble = true
	self.mWeight = 0
	self.mSkillTime = 0
	self.mRunTime = 0
end

function PlayerSkillState:Cache(state)

    if state == nil then
        return false
    end
    return self:AddLast(self,state)
end

function PlayerSkillState:AddLast(current, state)
    if current ~= nil then

        if current.mPlayerSkillType == state.mPlayerSkillType then
            return false
        end
        if current.mCacheSkillState ~= nil then
            if state.mWeight > current.mCacheSkillState.mWeight
                and self:ChangeAble(current, state.mPlayerSkillType)
                and self:ChangeAble(state, current.mCacheSkillState.mPlayerSkillType)
            then
                state.mCacheSkillState = current.mCacheSkillState
                current.mCacheSkillState = state
                return true
            else
                return self:AddLast(current.mCacheSkillState, state)
            end
        else
    
            if self:ChangeAble(current, state.mPlayerSkillType) then
    
                current.mCacheSkillState = state
                return true
    
            end
        end
    end

    return false
end

function PlayerSkillState:ChangeAble(state, skillType)

    if state ~= nil then

        for i,v in ipairs(state.mChangeList) do
            if v.mSkillType == skillType then
                return true
            end
        end

    end

    return false
end


function PlayerSkillState:OnEnter()

    if self.mSkillPluginList == nil then return end

    for i,v in ipairs(self.mSkillPluginList) do
        v:OnEnter()
    end

end

function PlayerSkillState:OnExit()

    self.mCacheSkillState = nil
    self.mSpeed = 1
    self.mChangeAt = 0
    self.mFadeLength = 0
    self.mChanging = false 
    self.mRunTime = 0

    if self.mSkillPluginList == nil then return end

    for i,v in ipairs(self.mSkillPluginList) do
        v:OnExit()
    end

end

function PlayerSkillState:OnExecute()

    if self.mSkillPluginList then
        for i,v in ipairs(self.mSkillPluginList) do
            v:OnExecute()
        end
    end

    self.mRunTime = self.mRunTime + Time.deltaTime * self.mSpeed

    if self.mChanging then
        if self.mRunTime > self.mChangeAt then
            self.mChanging = false
            self.mChangeAt  = self.mSkillTime
            self.mFadeLength = 0
            self.mSpeed = 0
        end
    end

    if self.mCacheSkillState ~=nil then

        if self.mChangeAble == false then
            if self.mRunTime >= self.mSkillTime then

                local tmpChange = self:GetSkillChange(self.mCacheSkillState.mPlayerSkillType)
                if tmpChange then
                    
                    self.mChanging = true
                    self.mCacheSkillState.mChangeAt = tmpChange.mBeginAt
                    self.mCacheSkillState.mSpeed = tmpChange.mSpeed
                    self.mCacheSkillState.mFadeLength = tmpChange.mFadeLength
                    self.mCacheSkillState.mChanging = true
                
                end
                self.machine:ChangeState(self.mCacheSkillState)

            end

            return 
        end
        if self.mRunTime > self.mSkillTime then
        

            local tmpChange = self:GetSkillChange(self.mCacheSkillState.mPlayerSkillType)
            if tmpChange then
            
                self.mChanging = true
                self.mCacheSkillState.mChangeAt = tmpChange.mBeginAt
                self.mCacheSkillState.mSpeed = tmpChange.mSpeed
                self.mCacheSkillState.mFadeLength = tmpChange.mFadeLength
                self.mCacheSkillState.mChanging = true
            end
            self.machine:ChangeState(self.mCacheSkillState)
        
        else
        
            local tmpCancel = self:GetSkillCancel(self.mCacheSkillState.mPlayerSkillType)

            if tmpCancel end self.mRunTime < tmpCancel.mBefore then
            
                self.mCacheSkillState.mFadeLength = tmpCancel.mFadeLength
                self.machine:ChangeState(self.mCacheSkillState)
            
            else
            
                local tmpChange = self:GetSkillChange(self.mCacheSkillState.mPlayerSkillType)

                if tmpChange then
                
                    if tmpChange.mEndAt == 0 then
                    
                        self.mChanging = true
                        self.mCacheSkillState.mSpeed = tmpChange.mSpeed
                        self.mCacheSkillState.mFadeLength = tmpChange.mFadeLength
                        self.mCacheSkillState.mChanging = true
                        self.machine:ChangeState(self.mCacheSkillState)
                    
                    else
                    
                        if self.mRunTime >= tmpChange.mEndAt then
                        
                            if tmpChange.mFadeLength > 0 then
                            
                                self.mSpeed = tmpChange.mSpeed
                                self.mChanging = true
                                self.mCacheSkillState.mSpeed = tmpChange.mSpeed
                                self.mCacheSkillState.mChanging = true
                                self.mCacheSkillState.mFadeLength = tmpChange.mFadeLength
                                self.mCacheSkillState.mChangeAt = tmpChange.mBeginAt
                            
                            else
                            
                                self.mChanging = true;
                                self.mCacheSkillState.mRunTime = tmpChange.mBeginAt
                                self.mCacheSkillState.mFadeLength = tmpChange.mFadeLength
                                self.mCacheSkillState.mChanging = true
                                self.machine:ChangeState(self.mCacheSkillState)
                            end

                        end

                    end
                
                else
                
                    print("Can Not Change " .. self.mCacheSkillState.mPlayerSkillType)
                end
            end
        end
    else

        if self.mRunTime > self.mSkillTime then

            local state = self.machine:GetPlayerSkillState(PlayerSkillType.Idle)
            if state then
                self.machine:ChangeState(state)                
            end
        end

    end

end

function PlayerSkillState:GetSkillChange(PlayerSkillType varSkillType)
	   
    if self.mChangeList == nil then return nil end

    for i,v in ipairs(self.mChangeList) do
          
        if v.mSkillType == varSkillType then
            return v;
        end

    end
    return nil

end

function PlayerSkillState:GetSkillCancel(PlayerSkillType varSkillType)

    if self.mChangeList == nil then return nil end

    for i,v in ipairs(self.mCancelList) do
          
        if v.mSkillType == varSkillType then
            return v;
        end

    end
    return nil
end

function PlayerSkillState:OnPause()
    
    if self.mSkillPluginList then
        for i,v in ipairs(self.mSkillPluginList) do
            v:OnPause()
        end
    end
end

function PlayerSkillState:OnResume()
    
    if self.mSkillPluginList then
        for i,v in ipairs(self.mSkillPluginList) do
                v:OnResume()
        end
    end
end