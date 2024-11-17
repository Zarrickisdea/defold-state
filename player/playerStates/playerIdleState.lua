-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local PlayerBaseState = require('player.playerStates.playerBaseState')

local PlayerIdleState = {{}, {__index = PlayerBaseState}}
PlayerIdleState.__index = PlayerIdleState
setmetatable(PlayerIdleState, {__index = PlayerBaseState})

function PlayerIdleState.new(player)
    local self = setmetatable({}, PlayerIdleState)
    self.player = player
    return self
end

function PlayerIdleState:enter()
    PlayerBaseState.enter(self)
    print('enter idle')
end

function PlayerIdleState:update(dt)
    PlayerBaseState.update(self, dt)
    print('update idle')
end

function PlayerIdleState:fixed_update(dt)
    PlayerBaseState.fixed_update(self, dt)
    print('fixed update idle')
end

function PlayerIdleState:exit()
    PlayerBaseState.exit(self)
    print('exit idle')
end

return PlayerIdleState
