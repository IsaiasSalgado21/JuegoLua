local physics = {}

function physics.applyFriction(obj, dt)
    obj.dx = obj.dx * (1 - obj.friction * dt)
    obj.dy = obj.dy * (1 - obj.friction * dt)
end

function physics.updatePosition(obj, dt)
    obj.x = obj.x + obj.dx * dt
    obj.y = obj.y + obj.dy * dt
end

return physics
