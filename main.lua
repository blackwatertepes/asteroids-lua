dev = require('dev') -- Development Only
lovetoys = require('lib/lovetoys.lovetoys')
lovetoys.initialize({ debug = true, globals = true })
bump = require('lib/bump')
require('asteroid')

local Ast = Component.load({'Ast'})
engine = lovetoys.Engine()

local AsteroidUpdateSystem = require('systems.AsteroidUpdateSystem')
local AsteroidDrawSystem = require('systems.AsteroidDrawSystem')

world = bump.newWorld()

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
