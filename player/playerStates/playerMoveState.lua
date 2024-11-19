-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local PlayerBaseState = require('player.playerStates.playerBaseState')

local PlayerMoveState = {}
PlayerMoveState.__index = PlayerMoveState
setmetatable(PlayerMoveState, {__index = PlayerBaseState})

local MOVEMENT_ANIMATIONS = {
    anim_moveDown = 'walkDown',
    anim_moveUp = 'walkUp',
    anim_moveLeft = 'walkLeft',
    anim_moveRight = 'walkRight'
}

function PlayerMoveState.new(player)
    local self = setmetatable(PlayerBaseState.new(player), PlayerMoveState)
    return self
end

function PlayerMoveState:enter()
    PlayerBaseState.enter(self)
    self:playAnimation()
    print('enter move')
end

function PlayerMoveState:update(dt)
    PlayerBaseState.update(self, dt)
end

function PlayerMoveState:fixed_update(dt)
    PlayerBaseState.fixed_update(self, dt)
end

function PlayerMoveState:on_message(message_id, message, sender)
    PlayerBaseState.on_message(self, message_id, message, sender)
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

function PlayerMoveState:playAnimation()
    self.animationPrefix = 'walk'
    PlayerBaseState.playAnimation(self)
end

return PlayerMoveState
