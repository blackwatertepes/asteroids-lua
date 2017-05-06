dev = require('dev') -- Development Only
lovetoys = require('lib/lovetoys.lovetoys')
lovetoys.initialize({ debug = true, globals = true })
bump = require('lib/bump')

world = bump.newWorld()
engine = lovetoys.Engine()

require('components.asteroid')
require('components.player')
require('components.game')
require('components.bullet')
local Game = Component.load({'Game'})

local AsteroidUpdateSystem = require('systems.AsteroidUpdateSystem')
local AsteroidDrawSystem = require('systems.AsteroidDrawSystem')
local PlayerDrawSystem = require('systems.PlayerDrawSystem')
local PlayerUpdateSystem = require('systems.PlayerUpdateSystem')
local BulletDrawSystem = require('systems.BulletDrawSystem')
local BulletUpdateSystem = require('systems.BulletUpdateSystem')
local GameUpdateSystem = require('systems.GameUpdateSystem')

function love.load()
  dev.load()

  love.window.setTitle('Asteroids')

  engine:addSystem(AsteroidUpdateSystem())
  engine:addSystem(AsteroidDrawSystem())
  engine:addSystem(PlayerDrawSystem())
  engine:addSystem(PlayerUpdateSystem())
  engine:addSystem(BulletDrawSystem())
  engine:addSystem(BulletUpdateSystem())
  engine:addSystem(GameUpdateSystem())

  game = lovetoys.Entity()
  game:add(Game())
  engine:addEntity(game)
end

function love.update(dt)
  dev.update(dt)
  engine:update(dt)
end

function love.draw()
  dev.draw()
  engine:draw()
end
