dev = require('dev') -- Development Only
lovetoys = require('lib/lovetoys.lovetoys')
lovetoys.initialize({ debug = true, globals = true })
bump = require('lib/bump')

require('components.asteroid')
require('components.player')
local Asteroid, Player = Component.load({'Asteroid', 'Player'})

local AsteroidUpdateSystem = require('systems.AsteroidUpdateSystem')
local AsteroidDrawSystem = require('systems.AsteroidDrawSystem')
local PlayerDrawSystem = require('systems.PlayerDrawSystem')

world = bump.newWorld()
engine = lovetoys.Engine()

local asteroid_eta = 1 -- Seconds between asteroids
local asteroid_last = love.timer.getTime() -- Time of last asteroid

function love.load()
  dev.load()

  love.window.setTitle('Asteroids')

  engine:addSystem(AsteroidUpdateSystem())
  engine:addSystem(AsteroidDrawSystem())
  engine:addSystem(PlayerDrawSystem())

  createPlayer()
end

function love.update(dt)
  dev.update(dt)

  -- TODO: Move this into another class
  if love.timer.getTime() - asteroid_last > asteroid_eta then
    createAsteroid()
    asteroid_last = love.timer.getTime()
  end

  --print('Entity Count: ', #engine:getEntitiesWithComponent('Asteroid'))
  engine:update(dt)
end

function love.draw()
  dev.draw()

  engine:draw()
end

function createPlayer()
  player = lovetoys.Entity()
  player:add(Player())
  engine:addEntity(player)
  local comp = player.components.Player
  world:add(player, comp.x, comp.y, comp.size, comp.size)
end

function createAsteroid()
  asteroid = lovetoys.Entity()
  asteroid:add(Asteroid())
  engine:addEntity(asteroid)
  local comp = asteroid.components.Asteroid
  world:add(asteroid, comp.x, comp.y, comp.size, comp.size)
end
