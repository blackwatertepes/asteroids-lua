dev = require('dev') -- Development Only
lovetoys = require('lib/vendor/lovetoys.lovetoys')
lovetoys.initialize({ debug = true, globals = true })
bump = require('lib/vendor/bump')
uuid = require('lib/vendor/uuid')

world = bump.newWorld()
engine = lovetoys.Engine()

require('lib/components.debris')
require('lib/components.asteroid')
require('lib/components.player')
require('lib/components.game')
require('lib/components.bullet')
local Game = Component.load({'Game'})

local AsteroidUpdateSystem = require('lib/systems.AsteroidUpdateSystem')
local AsteroidDrawSystem = require('lib/systems.AsteroidDrawSystem')
local PlayerDrawSystem = require('lib/systems.PlayerDrawSystem')
local PlayerUpdateSystem = require('lib/systems.PlayerUpdateSystem')
local BulletDrawSystem = require('lib/systems.BulletDrawSystem')
local BulletUpdateSystem = require('lib/systems.BulletUpdateSystem')
local DebrisDrawSystem = require('lib/systems.DebrisDrawSystem')
local DebrisUpdateSystem = require('lib/systems.DebrisUpdateSystem')
local GameUpdateSystem = require('lib/systems.GameUpdateSystem')

function love.load()
  dev.load() -- Development Only

  local uuidFile = 'uuid'
  local userId = love.filesystem.read(uuidFile)
  if userId then
    print('existing uuid found: ', userId)
  else
    -- Generate a UUID, and store it locally
    uuid.randomseed(love.timer.getTime())
    userId = uuid()
    success = love.filesystem.write(uuidFile, userId)
    print(success, ' wrote uuid to ', love.filesystem.getSaveDirectory())
  end

  engine:addSystem(AsteroidUpdateSystem())
  engine:addSystem(AsteroidDrawSystem())
  engine:addSystem(PlayerDrawSystem())
  engine:addSystem(PlayerUpdateSystem())
  engine:addSystem(BulletDrawSystem())
  engine:addSystem(BulletUpdateSystem())
  engine:addSystem(DebrisDrawSystem())
  engine:addSystem(DebrisUpdateSystem())
  engine:addSystem(GameUpdateSystem())

  game = lovetoys.Entity()
  game:add(Game())
  engine:addEntity(game)
end

function love.update(dt)
  dev.update(dt) -- Development Only
  engine:update(dt)
end

function love.draw()
  dev.draw() -- Development Only
  engine:draw()
end
