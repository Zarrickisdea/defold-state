-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local BaseState = require('stateMachine.baseState.baseState')

local CompositeState = {{}, {__index = BaseState}}
CompositeState.__index = CompositeState

function CompositeState.new()
    local self = setmetatable(BaseState.new(), CompositeState)
    self.substates = {}
    self.currentSubState = nil
    return self
end

function CompositeState:addState(name, state)
    self.substates[name] = state
end

function CompositeState:changeSubState(newStateName, conditionCallback)
    if self.substates[newStateName] and (not conditionCallback or conditionCallback()) then
        if self.currentSubState then
            self.currentSubState:exit()
        end
        self.currentSubState = self.substates[newStateName]
        self.currentSubState:enter()
    end
end

function CompositeState:deactivateSubStates()
    for name, state in pairs(self.substates) do
        state:exit()
    end
    self.currentSubState = nil
end

function CompositeState:enter()
    BaseState.enter(self)
    if self.currentSubState then
        self.currentSubState:enter()
    end
end

function CompositeState:exit()
    if self.currentSubState then
        self.currentSubState:exit()
    end
    BaseState.exit(self)
end

function CompositeState:update(dt)
    if self.currentSubState then
        self.currentSubState:update(dt)
    else
        BaseState.update(self, dt)
    end
end

function CompositeState:getCurrentSubState()
    for name, state in pairs(self.substates) do
        if state == self.currentSubState then
            return name
        end
    end
    return nil
end

return CompositeState
