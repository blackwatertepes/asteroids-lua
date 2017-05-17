local GameDrawSystem = class("GameDrawSystem", System)
local arial = love.graphics.newFont('assets/fonts/Arial.ttf', 48)

function GameDrawSystem:draw(dt)
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Game
    -- TODO: Refactor into a screen component
    love.graphics.setColor(255, 255, 255, 255)
    startText = love.graphics.newText(arial, 'Click to Start')
    --love.graphics.draw(startText, love.graphics.getWidth() / 2 - startText:getWidth() / 2, love.graphics:getHeight() / 2 - startText:getHeight() / 2)
  end
end

function GameDrawSystem:requires()
  return {'Game'}
end

return GameDrawSystem
