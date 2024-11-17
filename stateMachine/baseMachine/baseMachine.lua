-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local BaseMachine = {}
BaseMachine.__index = BaseMachine

function BaseMachine.new()
    local self = setmetatable({}, BaseMachine)
    return self
end

function BaseMachine:initialize(initialState, stateList)
    self.states = stateList
    self.currentState = initialState
    -- print('initialize state machine')
    -- print('current state: ' .. tostring(self.currentState))
    -- local stateNames = {}
    -- for name, _ in pairs(self.states) do
    --     table.insert(stateNames, name)
    -- end
    -- print('available states: ' .. table.concat(stateNames, ', '))

end

function BaseMachine:changeState(newState, conditionCallback)
    if self.states[newState] and (not conditionCallback or conditionCallback()) then
        if self.currentState then
            self.currentState:exit()
        end
        self.currentState = self.states[newState]
        self.currentState:enter()
    end
end

function BaseMachine:shutdown()
    if self.currentState then
        self.currentState:exit()
    end
end

function BaseMachine:getCurrentState()
    if self.currentState then
        for name, state in pairs(self.states) do
            if state == self.currentState then
                return self.currentState, name
            end
        end
        return self.currentState, nil
    end
    return nil, nil
end

return BaseMachine
