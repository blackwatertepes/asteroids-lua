local Game = Component.create('Game')
function Game:initialize()
  self.asteroid_eta = 1 -- Seconds between asteroids
  self.asteroid_last = love.timer.getTime() -- Time of last asteroid
  self.player = nil

  -- Menu
  -- TODO: Figure out how to add text
  --love.graphics.newText(Arial, 'Click to Start')
end
