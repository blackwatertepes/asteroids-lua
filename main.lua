dev = require('dev') -- Development
tick = require('lib/tick')
bump = require('lib/bump')
require('asteroid')

world = bump.newWorld()
asteroids = {}

function love.load()
  dev.load()
  tick.framerate = 60
end

function love.update(dt)
  dev.update(dt)

  if love.math.random() < 1 then
    asteroid = Asteroid(love.math.random(love.graphics.getWidth()), love.math.random(love.graphics.getHeight()), 1)
    table.insert(asteroids, asteroid)
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
