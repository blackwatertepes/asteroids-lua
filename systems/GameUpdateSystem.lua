local GameUpdateSystem = class("GameUpdateSystem", System)
local Asteroid, Player = Component.load({'Asteroid', 'Player'})

function GameUpdateSystem:update(dt)
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Game
    if love.timer.getTime() - comp.asteroid_last > comp.asteroid_eta then
      createAsteroid()
      comp.asteroid_last = love.timer.getTime()
    end
    if comp.player == nil then
      comp.player = createPlayer()
    end
  end
end

function GameUpdateSystem:requires()
  return {'Game'}
end

function createPlayer()
  player = lovetoys.Entity()
  player:add(Player())
  engine:addEntity(player)
  local comp = player.components.Player
  world:add(player, comp.x, comp.y, comp.size, comp.size)
  return player
end

function createAsteroid()
  asteroid = lovetoys.Entity()
  asteroid:add(Asteroid())
  engine:addEntity(asteroid)
  local comp = asteroid.components.Asteroid
  world:add(asteroid, comp.x, comp.y, comp.size, comp.size)
  return asteroid
end

return GameUpdateSystem
