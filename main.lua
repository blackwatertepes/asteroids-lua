dev = require('dev') -- Development Only
lovetoys = require('lib/vendor/lovetoys.lovetoys')
lovetoys.initialize({ debug = true, globals = true })
bump = require('lib/vendor/bump')
lume = require('lib/vendor/lume')
uuid = require('lib/vendor/uuid')

world = bump.newWorld()
engine = lovetoys.Engine()

require('lib/components.object')
require('lib/components.debris')
require('lib/components.asteroid')
require('lib/components.bullet')
require('lib/components.explosion')
require('lib/components.grenade')
require('lib/components.player')
require('lib/components.game')
local Game = Component.load({'Game'})

local ObjectUpdateSystem = require('lib/systems.ObjectUpdateSystem')
local AsteroidUpdateSystem = require('lib/systems.AsteroidUpdateSystem')
local AsteroidDrawSystem = require('lib/systems.AsteroidDrawSystem')
local PlayerDrawSystem = require('lib/systems.PlayerDrawSystem')
local PlayerUpdateSystem = require('lib/systems.PlayerUpdateSystem')
local BulletDrawSystem = require('lib/systems.BulletDrawSystem')
local BulletUpdateSystem = require('lib/systems.BulletUpdateSystem')
local GrenadeDrawSystem = require('lib/systems.GrenadeDrawSystem')
local GrenadeUpdateSystem = require('lib/systems.GrenadeUpdateSystem')
local ExplosionDrawSystem = require('lib/systems.ExplosionDrawSystem')
local ExplosionUpdateSystem = require('lib/systems.ExplosionUpdateSystem')
local DebrisDrawSystem = require('lib/systems.DebrisDrawSystem')
local GameDrawSystem = require('lib/systems.GameDrawSystem')
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

  engine:addSystem(ObjectUpdateSystem())
  engine:addSystem(AsteroidUpdateSystem())
  engine:addSystem(AsteroidDrawSystem())
  engine:addSystem(DebrisDrawSystem())
  engine:addSystem(BulletDrawSystem())
  engine:addSystem(BulletUpdateSystem())
  engine:addSystem(GrenadeDrawSystem())
  engine:addSystem(GrenadeUpdateSystem())
  engine:addSystem(ExplosionDrawSystem())
  engine:addSystem(ExplosionUpdateSystem())
  engine:addSystem(PlayerDrawSystem())
  engine:addSystem(PlayerUpdateSystem())
  engine:addSystem(GameDrawSystem())
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
