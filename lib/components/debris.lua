local Object = Component.load({'Object'})

local Debris = Component.create('Debris')
function Debris:initialize(opts)
  local distX, distY = opts.bx - opts.ax, opts.by - opts.ay
  self.size = math.sqrt(math.pow(distX, 2) + math.pow(distY, 2))
end
