local Object = Component.create('Object')
function Object:initialize(opts)
  self.x = opts.x
  self.y = opts.y
  self.width = opts.width or 0
  self.height = opts.height or 0
  self.rotation = opts.rotation or 0
  self.vector = opts.vector or 0
  self.speed = opts.speed or 0
  self.stepRot = opts.rotationSpeed or 0
  self.stepX = self.speed * math.cos(self.vector)
  self.stepY = self.speed * math.sin(self.vector)
  self.origin = {x = self.x, y = self.y}
  self.updatable = opts.updatable or false
  self.removable = opts.removable or false
end

function Object:update(dt)
  if self.updatable then
    self.rotation = self.rotation + (self.stepRot * dt)
    self.x = self.x + (self.stepX * dt)
    self.y = self.y + (self.stepY * dt)
  end
end

function Object:offScreen()
  return self.x < 10 or self.y < 10 or self.x > love.graphics.getWidth() - 10 or self.y > love.graphics.getHeight() - 10
end

function Object:canRemove()
  return self:offScreen() and self.removable
end

function Object:remove(entity)
  if self:canRemove() then
    engine:removeEntity(entity)
  end
end
