local Asteroid = Component.create('Asteroid')
function Asteroid:initialize(x, y, velocity)
    self.x = x
    self.y = y
    self.size = 10
    self.velocity = velocity
    -- TODO: This is calculated incorrectly!
    self.velocityX = velocity * love.math.random()
    if love.math.random() > .5 then
      self.velocityX = -self.velocityX
    end
    self.velocityY = velocity - self.velocityX
    if love.math.random() > .5 then
      self.velocityY = -self.velocityY
    end
end
