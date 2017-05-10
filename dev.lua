-- This file is used purely for development purposes only
-- Upon final packaging of the game, please be sure to remove any references to it
-- This will mostly likely include the require, load, update, and draw functions within main

local dev = {}

debugGraph = require('lib/vendor/debugGraph') -- FPS & Mem
lovebird = require('lib/vendor/lovebird') -- Output to Browser
lurker = require('lib/vendor/lurker') -- Hot Reload

function dev.load()
  fpsGraph = debugGraph:new('fps', 0, 0)
  memGraph = debugGraph:new('mem', 0, 30)
  lovebird.update()
end

function dev.update(dt)
  fpsGraph:update(dt)
  memGraph:update(dt)
  lovebird.update()
  lurker.update()
end

function dev.draw()
  fpsGraph:draw()
  memGraph:draw()
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

return dev
