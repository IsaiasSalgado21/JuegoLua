local physics = require("src.physics")
local wall = require("src.wall")

local player = {
    x = 100,
    y = 100,
    width = 32,
    height = 32,
    dx = 0,
    dy = 0,
    acceleration = 170,
    friction = 3,
    maxSpeed = 200,
    currentFrame = 0,
    totalFrames = 4,
    timePerFrame = 0.2,
    elapsedTime = 0
}

function player.update(dt)
    if love.keyboard.isDown("right") then
        player.dx = math.min(player.dx + player.acceleration * dt, player.maxSpeed)
    elseif love.keyboard.isDown("left") then
        player.dx = math.max(player.dx - player.acceleration * dt, -player.maxSpeed)
    else
        physics.applyFriction(player, dt)
    end

    if love.keyboard.isDown("down") then
        player.dy = math.min(player.dy + player.acceleration * dt, player.maxSpeed)
    elseif love.keyboard.isDown("up") then
        player.dy = math.max(player.dy - player.acceleration * dt, -player.maxSpeed)
    else
        physics.applyFriction(player, dt)
    end

    -- 1) moverse en X y resolver contra muros
    player.x = player.x + player.dx * dt
    wall.resolveX(player)

    -- 2) moverse en Y y resolver contra muros
    player.y = player.y + player.dy * dt
    wall.resolveY(player)
end

function player.draw(sprites)
    love.graphics.draw(sprites[player.currentFrame], player.x, player.y)
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
    love.graphics.setColor(255, 255, 255)
end

return player
