dev = require('dev') -- Development Only
lovetoys = require('lib/lovetoys.lovetoys')
lovetoys.initialize({ debug = true, globals = true })
bump = require('lib/bump')

require('components.asteroid')
local Asteroid = Component.load({'Asteroid'})

local AsteroidUpdateSystem = require('systems.AsteroidUpdateSystem')
local AsteroidDrawSystem = require('systems.AsteroidDrawSystem')

world = bump.newWorld()
engine = lovetoys.Engine()

function love.load()
  dev.load()

  engine:addSystem(AsteroidUpdateSystem())
  engine:addSystem(AsteroidDrawSystem())
end

function love.update(dt)
  dev.update(dt)

  --if love.math.random() < 1 then
  for i = 1, 100 do
    createAsteroid()
  end

  print('Entity Count: ', #engine:getEntitiesWithComponent('Asteroid'))
  engine:update(dt)
end

function love.draw()
  dev.draw()

  engine:draw()
end

function createAsteroid()
  asteroid = lovetoys.Entity()
  local x, y, velocity = love.math.random(love.graphics.getWidth()), love.math.random(love.graphics.getHeight()), 1
  asteroid:add(Asteroid(x, y, velocity))
  engine:addEntity(asteroid)
  world:add(asteroid, asteroid.components.Asteroid.x, asteroid.components.Asteroid.y, asteroid.components.Asteroid.size, asteroid.components.Asteroid.size)
end
