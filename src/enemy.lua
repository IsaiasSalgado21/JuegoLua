local physics = require("src.physics")
local collision = require("src.collision")

local enemies = {}
local enemySpawnTimer = 0
local enemySpawnInterval = 2
local maxEnemies = 20
local collisionDetected = false

function enemies.spawn()
    local newEnemy = {
        x = love.math.random(0, love.graphics.getWidth()),
        y = -50,
        width = 32,
        height = 32,
        speed = 50,
        currentFrame = 0,
        totalFrames = 4,
        timePerFrame = 0.2,
        elapsedTime = 0
    }
    table.insert(enemies, newEnemy)
end

function enemies.update(dt, player)
    collisionDetected = false
    enemySpawnTimer = enemySpawnTimer + dt
    if enemySpawnTimer >= enemySpawnInterval and #enemies < maxEnemies then
        enemies.spawn()
        enemySpawnTimer = 0
    end

    for i, enemy in ipairs(enemies) do
        local angle = math.atan2(player.y - enemy.y, player.x - enemy.x)
        enemy.dx = enemy.speed * math.cos(angle)
        enemy.dy = enemy.speed * math.sin(angle)
        
        physics.updatePosition(enemy, dt)
        
        if enemy.y > love.graphics.getHeight() then
            table.remove(enemies, i)
        end

        if collision.check(enemy, player) then
            collisionDetected = true
        end
    end
end

function enemies.draw(spritesEnemigos)
    for _, enemy in ipairs(enemies) do
        love.graphics.draw(spritesEnemigos[enemy.currentFrame], enemy.x, enemy.y)
        love.graphics.setColor(255, 0, 0)
        love.graphics.rectangle("line", enemy.x, enemy.y, enemy.width, enemy.height)
        love.graphics.setColor(255, 255, 255)
    end
end

function enemies.isCollisionDetected()
    return collisionDetected
end

return enemies
