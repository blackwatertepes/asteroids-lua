dev = require('dev') -- Development Only
lovetoys = require('lib/lovetoys.lovetoys')
lovetoys.initialize({ debug = true, globals = true })
bump = require('lib/bump')
require('asteroid')

local Ast = Component.load({'Ast'})
engine = lovetoys.Engine()
AsteroidUpdateSystem = class('AsteroidUpdateSystem', System)
AsteroidDrawSystem = class('AsteroidDrawSystem', System)

function AsteroidUpdateSystem:update()
  print('update')
  for i, entity in pairs(self.targets) do
    local goalX = entity.components.Ast.x + entity.components.Ast.velocityX
    local goalY = entity.components.Ast.y + entity.components.Ast.velocityY
    local actualX, actualY, cols, len = world:move(entity.components.Ast, goalX, goalY)
    if len == 0 then
      entity.components.Ast.x = actualX
      entity.components.Ast.y = actualY
    else
      world:remove(entity.components.Ast)
      engine:removeEntity(entity)
    end
  end
end

function AsteroidUpdateSystem:requires()
  return {'Ast'}
end

function AsteroidDrawSystem:draw()
  for i, entity in pairs(self.targets) do
    local x, y, size = entity:get('Ast').x, entity:get('Ast').y, entity:get('Ast').size
    love.graphics.rectangle('fill', x, y, size, size)
  end
end

function AsteroidDrawSystem:requires()
  return {'Ast'}
end

world = bump.newWorld()
asteroids = {}

function love.load()
  dev.load()

  engine:addSystem(AsteroidUpdateSystem())
  engine:addSystem(AsteroidDrawSystem())
end

function love.update(dt)
  dev.update(dt)

  if love.math.random() < 1 then
    ast = lovetoys.Entity()
    local x, y, velocity = love.math.random(love.graphics.getWidth()), love.math.random(love.graphics.getHeight()), 1
    ast:add(Ast(x, y, velocity))
    engine:addEntity(ast)

    world:add(ast.components.Ast, ast.components.Ast.x, ast.components.Ast.y, ast.components.Ast.size, ast.components.Ast.size)
  end

  engine:update(dt)
end

function love.draw()
  dev.draw()

  engine:draw()
end
