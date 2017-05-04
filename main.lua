dev = require('dev') -- Development
require('asteroid')

function love.load()
  dev.load()

  asteroid = Asteroid(100, 100)
end

function love.update(dt)
  dev.update(dt)

  asteroid.x = asteroid.x + 1
end

function love.draw()
  dev.draw()

  asteroid:draw()
end
