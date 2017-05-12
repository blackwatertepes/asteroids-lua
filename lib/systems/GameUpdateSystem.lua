local GameUpdateSystem = class("GameUpdateSystem", System)
local Asteroid, Player = Component.load({'Asteroid', 'Player'})

function GameUpdateSystem:update(dt)
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Game
    if love.timer.getTime() - comp.asteroid_last > comp.asteroid_eta then
      local screenW, screenH = love.graphics.getWidth(), love.graphics.getHeight()
      local startAngle = math.random() * math.pi*2
      -- TODO: the start dist (screenW * .5) is for dev
      -- TODO: Remove the .5 before deploy (ex: screenW)
      local start = asteroidXY(screenW / 2, screenH / 2, screenW * .5, startAngle)
      local randVector = math.atan2(screenH / 2 - start.y, screenW / 2 - start.x) * math.random(80, 120) / 100
      createWorldEntity(Asteroid({size = math.random(60, 80), x = start.x, y = start.y, speed = math.random(40, 80), vector = randVector}))
      comp.asteroid_last = love.timer.getTime()
    end
    if comp.player == nil then --and love.mouse.get() then
      comp.player = createWorldEntity(Player())
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

function createEntity(comp)
  local entity = lovetoys.Entity()
  entity:add(comp)
  engine:addEntity(entity)
  return entity
end

function createWorldEntity(comp)
  local entity = createEntity(comp)
  world:add(entity, comp.x, comp.y, comp.size, comp.size)
  return entity
end

return GameUpdateSystem
