class = require('util/middleclass')

Asteroid = class('Asteroid')

function Asteroid:initialize(x, y)
  self.x = x
  self.y = y
end
