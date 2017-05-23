local GameUpdateSystem = class("GameUpdateSystem", System)
local Object, Debris, Asteroid, Player = Component.load({'Object', 'Debris', 'Asteroid', 'Player'})

function GameUpdateSystem:update(dt)
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Game
    if love.timer.getTime() - comp.asteroid_last > comp.asteroid_eta then
      local screenW, screenH = love.graphics.getWidth(), love.graphics.getHeight()
      local startAngle = math.random() * math.pi*2
      -- TODO: Remove the .5 before deploy (ex: screenW)
      local start = asteroidXY(screenW / 2, screenH / 2, screenW * .5, startAngle)
      local randVector = math.atan2(screenH / 2 - start.y, screenW / 2 - start.x) * math.random(80, 120) / 100
      createAsteroid({x = start.x, y = start.y, speed = math.random(40, 80), vector = randVector, size = math.random(60, 80)})
      comp.asteroid_last = love.timer.getTime()
    end
    if comp.player == nil then --and love.mouse.get() then
      comp.player = createPlayer()
    end
  end
end

function GameUpdateSystem:requires()
  return {'Game'}
end

function asteroidXY(x, y, dist, angle)
  -- Calc the x,y coord at a certain angle a certain distance from a start x,y coord
  local sX = x + dist * math.cos(angle)
  local sY = y + dist * math.sin(angle)
  return {x = sX, y = sY}
end

function createDebris(ax, ay, bx, by)
  local vector = math.random() * math.pi*2
  local rotation = math.atan2(by - ay, bx - ax)
  local rotationSpeed = math.random() * 10 - 10 / 2
  local object = Object({x = ax, y = ay, speed = 40, vector = vector, rotation = rotation, rotationSpeed = rotationSpeed, updatable = true, removable = true})
  local debris = Debris({ax = ax, ay = ay, bx = bx, by = by})
  createEntity({object, debris})
end

function createAsteroid(opts)
  local object = Object({x = opts.x, y = opts.y, width = opts.size, height = opts.size, speed = opts.speed, vector = opts.vector})
  local asteroid = Asteroid({x = opts.x, y = opts.y, vector = opts.vector, size = opts.size})
  createWorldEntity(object, {asteroid})
end

function createPlayer()
  local size = 40
  local x = love.graphics.getWidth() / 2 - size / 2
  local y = love.graphics.getHeight() / 2 - size / 2
  local object = Object({x = x, y = y, width = size, height = size})
  return createWorldEntity(object, {Player()})
end

function createEntity(comps)
  local entity = lovetoys.Entity()
  for i, comp in pairs(comps) do
    entity:add(comp)
  end
  engine:addEntity(entity)
  return entity
end

function createWorldEntity(worldComp, comps)
  local entity = createEntity(comps)
  entity:add(worldComp)
  world:add(entity, worldComp.x, worldComp.y, worldComp.width, worldComp.height)
  return entity
end

return GameUpdateSystem
