local GameUpdateSystem = class("GameUpdateSystem", System)
local Asteroid, Player = Component.load({'Asteroid', 'Player'})

function GameUpdateSystem:update(dt)
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Game
    if love.timer.getTime() - comp.asteroid_last > comp.asteroid_eta then
      createEntity(Asteroid())
      comp.asteroid_last = love.timer.getTime()
    end
    if comp.player == nil then
      comp.player = createEntity(Player())
    end
  end
end

function GameUpdateSystem:requires()
  return {'Game'}
end

function createEntity(comp)
  local entity = lovetoys.Entity()
  entity:add(comp)
  engine:addEntity(entity)
  world:add(entity, comp.x, comp.y, comp.size, comp.size)
  return entity
end

return GameUpdateSystem
