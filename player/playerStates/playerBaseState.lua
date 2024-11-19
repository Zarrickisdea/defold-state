-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local BaseState = require('stateMachine.baseState.baseState')

local PlayerBaseState = {}
PlayerBaseState.__index = PlayerBaseState
setmetatable(PlayerBaseState, {__index = BaseState})

local MOVEMENT_KEYS = {
    hash("up"),
    hash("down"),
    hash("left"),
    hash("right")
}

function PlayerBaseState.new(player)
    local self = setmetatable({}, PlayerBaseState)
    self.player = player
    self.stateTimer = 0
    self.animationPrefix = nil
    self.keyTable = player.keyTable
    return self
end

function PlayerBaseState:enter()
    self.stateTimer = 0
    print('enter base')
end

function PlayerBaseState:update(dt)
    self.stateTimer = self.stateTimer + dt
end

function PlayerBaseState:fixed_update(dt)
end

function PlayerBaseState:on_message(message_id, message, sender)
end

function PlayerBaseState:on_input(action_id, action)
    if action.pressed then
        self.keyTable[action_id] = { pressed = true }
        print('pressed ' .. tostring(self.keyTable[action_id]) .. ' ' .. tostring(self.keyTable[action_id].pressed))
    elseif action.released then
        self.keyTable[action_id] = { pressed = false }
        print('released ' .. tostring(self.keyTable[action_id]) .. ' ' .. tostring(self.keyTable[action_id].pressed))
    end
end

function PlayerBaseState:exit()
    self.stateTimer = 0
    print('exit base')
end

function PlayerBaseState:playAnimation()
    local direction = self.player.direction

    if direction.x == 0 and direction.y == 0 then
        print('direction is 0')
        return
    end

    local animationName = self.animationPrefix .. self:getDirectionString()
    print('playing animation ' .. animationName)
    sprite.play_flipbook(self.player.spriteUrl, animationName)
end

function PlayerBaseState:isMovementKey(action_id)
    for _,key in pairs(MOVEMENT_KEYS) do
        if action_id == key then
            return true
        end
    end
    return false
end

function PlayerBaseState:assignDirection(action_id)
    if action_id == hash("up") then
        self.player.direction = { x = 0, y = 1 }
    elseif action_id == hash("down") then
        self.player.direction = { x = 0, y = -1 }
    elseif action_id == hash("left") then
        self.player.direction = { x = -1, y = 0 }
    elseif action_id == hash("right") then
        self.player.direction = { x = 1, y = 0 }
    end
    print('assigned direction ' .. self:getDirectionString())
end

function PlayerBaseState:getDirectionString()
    local direction = self.player.direction
    if direction.x == 1 then
        return 'Right'
    elseif direction.x == -1 then
        return 'Left'
    elseif direction.y == 1 then
        return 'Up'
    elseif direction.y == -1 then
        return 'Down'
    end
end

function PlayerBaseState:isMovementKeyPressed()
    for name, state in pairs(self.keyTable) do
        if self:isMovementKey(name) and state.pressed then
            self:assignDirection(name)
            return true
        end
    end
    print('No movement keys pressed')
    return false
end

return PlayerBaseState