-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local BaseMachine = require('stateMachine.baseMachine.baseMachine')

local PlayerStateMachine = {}
PlayerStateMachine.__index = PlayerStateMachine
setmetatable(PlayerStateMachine, {__index = BaseMachine})

function PlayerStateMachine.new()
    local self = setmetatable({}, PlayerStateMachine)
    return self
end

function PlayerStateMachine:initialize(initialState, stateList)
    BaseMachine.initialize(self, initialState, stateList)
end

function PlayerStateMachine:shutdown()
    BaseMachine.shutdown(self)
end

function PlayerStateMachine:changeState(newState, conditionCallback)
    BaseMachine.changeState(self, newState, conditionCallback)
    print('change state to ' .. newState)
end

function PlayerStateMachine:getCurrentState()
    return BaseMachine.getCurrentState(self)
end

return PlayerStateMachine
