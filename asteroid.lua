Class = require('lib/hump.class')

local Ast = Component.create('Ast')
function Ast:initialize(x, y, velocity)
    self.x = x
    self.y = y
    self.size = 20
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

Asteroid = Class{
  init = function(self, x, y, velocity)
    self.x = x
    self.y = y
    self.size = 20
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

    world:add(self, self.x, self.y, self.size, self.size)
  end;

  update = function(self)
    local goalX = self.x + self.velocityX
    local goalY = self.y + self.velocityY
    local actualX, actualY, cols, len = world:move(self, goalX, goalY)
    self.x = actualX
    self.y = actualY
  end;

  draw = function(self)
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
  end;
}
