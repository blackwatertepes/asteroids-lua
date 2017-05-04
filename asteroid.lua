Class = require('util/hump/class')

Asteroid = Class{
  init = function(self, x, y)
    self.x = x
    self.y = y
  end;

  draw = function(self)
    love.graphics.rectangle('fill', self.x, self.y, 20, 20)
  end
}
