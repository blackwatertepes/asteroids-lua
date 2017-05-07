local Game = Component.create('Game')
function Game:initialize()
  self.asteroid_eta = 1 -- Seconds between asteroids
  self.asteroid_last = love.timer.getTime() -- Time of last asteroid
  self.player = nil
end
