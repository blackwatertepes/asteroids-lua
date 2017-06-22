local Player = Component.create('Player')
local Object, Bullet, Grenade = Component.load({'Object', 'Bullet', 'Grenade'})
function Player:initialize()
  self.lastFired = 0
  self.highlight = false
  self.anchorXY = nil
end

function Player:anchorToMouse(opts)
  self.anchorXY = {x = love.mouse.getX(), y = love.mouse.getY()}
  opts.rotation = lume.angle(self.anchorXY.x, self.anchorXY.y, opts.x + opts.width / 2, opts.y + opts.height / 2)
end

function Player:releaseFromMouse()
  self.anchorXY = nil
end

function Player:loaded()
  return self.anchorXY ~= nil
end

function Player:fireBullet(opts)
  local size = 4
  local x, y = opts.x + opts.width / 2 - size / 2, opts.y + opts.height / 2 - size / 2
  local object = Object({x = x, y = y, width = size, height = size, rotation = opts.rotation, vector = opts.rotation})
  self:fire(createWorldEntity(object, {Bullet()}))
end

function Player:fireGrenade(dist, opts)
  local size = 4
  local x, y = opts.x + opts.width / 2 - size / 2, opts.y + opts.height / 2 - size / 2
  local object = Object({x = x, y = y, width = size, height = size, rotation = opts.rotation, vector = opts.rotation})
  self:fire(createWorldEntity(object, {Grenade(dist)}))
end

function Player:fire(proj)
  self.lastFired = love.timer.getTime()
  self:releaseFromMouse()
end
