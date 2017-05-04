local dev = {}

debugGraph = require('lib/debugGraph') -- FPS & Mem
lovebird = require('lib/lovebird') -- Output to Browser
lurker = require('lib/lurker') -- Hot Reload

function dev.load()
  fpsGraph = debugGraph:new('fps', 0, 0)
  memGraph = debugGraph:new('mem', 0, 30)
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
