-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local PlayerBaseState = require('player.playerStates.playerBaseState')

local PlayerIdleState = {}
PlayerIdleState.__index = PlayerIdleState
setmetatable(PlayerIdleState, {__index = PlayerBaseState})

local IDLE_ANIMATIONS = {
    anim_idleDown = 'idleDown',
    anim_idleUp = 'idleUp',
    anim_idleLeft = 'idleLeft',
    anim_idleRight = 'idleRight'
}

function PlayerIdleState.new(player)
    local self = setmetatable(PlayerBaseState.new(player), PlayerIdleState)
    return self
end

function PlayerIdleState:enter()
    PlayerBaseState.enter(self)
    print('enter idle')
    self:playAnimation()
end

function PlayerIdleState:update(dt)
    PlayerBaseState.update(self, dt)
end

function PlayerIdleState:fixed_update(dt)
    PlayerBaseState.fixed_update(self, dt)
end

function PlayerIdleState:on_message(message_id, message, sender)
    PlayerBaseState.on_message(self, message_id, message, sender)
end

function PlayerIdleState:on_input(action_id, action)
    PlayerBaseState.on_input(self, action_id, action)

    if self:isMovementKeyPressed() then
        print('idle to move' .. tostring(self:isMovementKeyPressed()))
        self.player.playerStateMachine:changeState('move')
    end
end

function PlayerIdleState:exit()
    PlayerBaseState.exit(self)
    print('exit idle')
end

function PlayerIdleState:playAnimation()
    self.animationPrefix = 'idle'
    PlayerBaseState.playAnimation(self)
end

return PlayerIdleState
