local Object = Component.create('Object')
function Object:initialize(opts)
  self.x = opts.x
  self.y = opts.y
  self.rotation = opts.rotation or 0
  self.vector = opts.vector or 0
  self.speed = opts.speed or 0
  self.stepRot = opts.rotationSpeed or 0
  self.stepX = self.speed * math.cos(self.vector)
  self.stepY = self.speed * math.sin(self.vector)
end

function Object:update(dt)
  self.rotation = self.rotation + (self.stepRot * dt)
  self.x = self.x + (self.stepX * dt)
  self.y = self.y + (self.stepY * dt)
end

function Object:offScreen()
  return self.x < 10 or self.y < 10 or self.x > love.graphics.getWidth() - 10 or self.y > love.graphics.getHeight() - 10
end

function Object:canRemove()
  return self:offScreen()
end

function Object:remove(entity)
  if self:canRemove() then
    engine:removeEntity(entity)
  end
end
