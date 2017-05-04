dev = require('dev') -- Development
tick = require('util/tick')
require('asteroid')

asteroids = {}

function love.load()
  dev.load()
  tick.framerate = 60
end

function love.update(dt)
  dev.update(dt)

  if love.math.random() < 0.1 then
    table.insert(asteroids, Asteroid(love.math.random(love.graphics.getWidth()), love.math.random(love.graphics.getHeight()), 1))
  end

  for i, asteroid in pairs(asteroids) do
    asteroid:update()
  end
end

function love.draw()
  dev.draw()

  for i, asteroid in pairs(asteroids) do
    asteroid:draw()
  end
end
