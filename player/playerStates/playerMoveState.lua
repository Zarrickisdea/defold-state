-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local PlayerBaseState = require('player.playerStates.playerBaseState')

local PlayerMoveState = {}
PlayerMoveState.__index = PlayerMoveState
setmetatable(PlayerMoveState, {__index = PlayerBaseState})

function PlayerMoveState.new(player)
    local self = setmetatable(PlayerBaseState.new(player), PlayerMoveState)
    return self
end

function PlayerMoveState:enter()
    PlayerBaseState.enter(self)
    print('enter move')
end

function PlayerMoveState:update(dt)
    PlayerBaseState.update(self, dt)
    -- if not self:isMovementKeyPressed() then
    --     print('move to idle ' .. tostring(self:isMovementKeyPressed()))
    --     self.player.playerStateMachine:changeState('idle')
    -- end
end

function PlayerMoveState:fixed_update(dt)
    PlayerBaseState.fixed_update(self, dt)
end

function PlayerMoveState:on_input(action_id, action)
    PlayerBaseState.on_input(self, action_id, action)

    if not self:isMovementKeyPressed() then
        print('move to idle ' .. tostring(self:isMovementKeyPressed()))
        self.player.playerStateMachine:changeState('idle')
    end
end

function PlayerMoveState:exit()
    PlayerBaseState.exit(self)
    print('exit move')
end

return PlayerMoveState
