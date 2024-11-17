-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local BaseState = require('stateMachine.baseState.baseState')

local PlayerBaseState = {{}, {__index = BaseState}}
PlayerBaseState.__index = PlayerBaseState
setmetatable(PlayerBaseState, {__index = BaseState})

local stateTimer = 0
local player = nil

function PlayerBaseState.new(player)
    local self = setmetatable({}, PlayerBaseState)
    self.player = player
    return self
end

function PlayerBaseState:enter()
    stateTimer = 0
    print('enter base')
end

function PlayerBaseState:update(dt)
    stateTimer = stateTimer + dt
    print('update base')
end

function PlayerBaseState:fixed_update(dt)
    print('fixed_update base')
end

function PlayerBaseState:exit()
    stateTimer = 0
    print('exit base')
end

return PlayerBaseState