-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local BaseState = {}
BaseState.__index = BaseState

function BaseState.new()
    local self = setmetatable({}, BaseState)
    return self
end

function BaseState:enter() end
function BaseState:exit() end
function BaseState:update(dt) end
function BaseState:fixed_update(dt) end

return BaseState
