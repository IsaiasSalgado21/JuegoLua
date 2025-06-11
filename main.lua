local player = require("src.player")
local enemies = require("src.enemy")
local wall = require("src.wall")

function love.load()
    sprites = {}
    for i = 0, 3 do
        sprites[i] = love.graphics.newImage("assets/sprites/sprite_" .. i .. ".png")
    end
    
    spritesEnemigos = {}
    for a = 0, 3 do
        spritesEnemigos[a] = love.graphics.newImage("assets/sprites/sprite_enemigo_" .. a .. ".png")
    end

    wall.create(20, 20, 30, 40)          -- Muro superior
    wall.create(0, 580, 800, 20)        -- Muro inferior
    wall.create(0, 0, 20, 600)          -- Muro izquierdo
    wall.create(780, 0, 20, 600)        -- Muro derecho
end

function love.update(dt)
    player.update(dt)
    enemies.update(dt, player)
end

function love.draw()
    player.draw(sprites)
    enemies.draw(spritesEnemigos)
    wall.draw()
    if enemies.isCollisionDetected() then
        love.graphics.print("true", love.graphics.getWidth() - 50, 10)
    end
end
