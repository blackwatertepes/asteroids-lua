Class = require('util/hump.class')

Asteroid = Class{
  init = function(self, x, y, velocity)
    self.x = x
    self.y = y
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
  end;

  update = function(self)
    self.x = self.x + self.velocityX
    self.y = self.y + self.velocityY
  end;

  draw = function(self)
    love.graphics.rectangle('fill', self.x, self.y, 20, 20)
  end;
}
