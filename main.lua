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

  if #engine:getEntitiesWithComponent('Asteroid') < 2 then
    createAsteroid()
  end

  --print('Entity Count: ', #engine:getEntitiesWithComponent('Asteroid'))
  engine:update(dt)
end

function love.draw()
  dev.draw()

  engine:draw()
end

function createAsteroid()
  asteroid = lovetoys.Entity()
  asteroid:add(Asteroid())
  engine:addEntity(asteroid)
  world:add(asteroid, asteroid.components.Asteroid.x, asteroid.components.Asteroid.y, asteroid.components.Asteroid.size, asteroid.components.Asteroid.size)
end
