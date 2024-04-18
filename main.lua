function love.load()
    -- Cargar imágenes de la animación del jugador
    sprites = {}
    for i = 0, 3 do
        sprites[i] = love.graphics.newImage("sprites/sprite_" .. i .. ".png")
    end
    
    -- Cargar imágenes de la animación del enemigo
    spritesEnemigos = {}
    for a = 0, 3 do
        spritesEnemigos[a] = love.graphics.newImage("sprites/sprite_enemigo_"..a..".png")
    end
    
    -- Inicializar jugador
    player = {
        x = 100,
        y = 100,
        width = 32, -- Ancho del jugador
        height = 32, -- Altura del jugador
        dx = 0,
        dy = 0,
        acceleration = 120,
        friction = 3,
        maxSpeed = 100,
        currentFrame = 0,
        totalFrames = 4,
        timePerFrame = 0.2,
        elapsedTime = 0
    }

    -- Inicializar enemigos
    enemies = {} -- Lista de enemigos activos
    enemySpawnTimer = 0
    enemySpawnInterval = 2 -- Generar un nuevo enemigo cada 2 segundos
    maxEnemies = 20 -- Número máximo de enemigos en pantalla
    spawnEnemy()
end

function love.update(dt)
    -- Actualizar movimiento del jugador
    updatePlayer(dt)

    -- Generar enemigos
    -- Generar un nuevo enemigo si ha pasado el intervalo de tiempo y hay espacio para más enemigos
    if enemySpawnTimer <= enemySpawnInterval and #enemies < maxEnemies then
        spawnEnemy()
        enemySpawnTimer = 0
    end
    
    -- Actualizar la posición y el estado de los enemigos
    for i, enemy in ipairs(enemies) do
        updateEnemy(enemy, dt)
        
        -- Eliminar enemigos que hayan salido de la pantalla
        if enemy.y > love.graphics.getHeight() then
            table.remove(enemies, i)
        end

        -- Comprobar colisión con el jugador
        if checkCollision(enemy, player) then
            -- Aquí puedes implementar alguna lógica para tratar la colisión
            -- Por ejemplo, restar puntos de vida al jugador
        end
    end
end

function updatePlayer(dt)
    -- Movimiento horizontal
    if love.keyboard.isDown("right") then
        player.dx = math.min(player.dx + player.acceleration * dt, player.maxSpeed)
    elseif love.keyboard.isDown("left") then
        player.dx = math.max(player.dx - player.acceleration * dt, -player.maxSpeed)
    else
        -- Aplicar fricción
        player.dx = player.dx * (1 - player.friction * dt)
    end

    -- Movimiento vertical
    if love.keyboard.isDown("down") then
        player.dy = math.min(player.dy + player.acceleration * dt, player.maxSpeed)
    elseif love.keyboard.isDown("up") then
        player.dy = math.max(player.dy - player.acceleration * dt, -player.maxSpeed)
    else
        -- Aplicar fricción
        player.dy = player.dy * (1 - player.friction * dt)
    end

    -- Aplicar velocidad
    player.x = player.x + player.dx * dt
    player.y = player.y + player.dy * dt

    -- Actualizar la animación del jugador
    updateAnimation(player, dt)
end

function updateEnemy(enemy, dt)
    -- Calcular la dirección hacia el jugador
    local angle = math.atan2(player.y - enemy.y, player.x - enemy.x)
    -- Calcular los componentes de velocidad en x e y
    local dx = enemy.speed * math.cos(angle)
    local dy = enemy.speed * math.sin(angle)
    -- Aplicar movimiento al enemigo
    enemy.x = enemy.x + dx * dt
    enemy.y = enemy.y + dy * dt

    updateAnimation(enemy, dt)
end

function updateAnimation(character, dt)
    -- Incrementar el tiempo transcurrido
    character.elapsedTime = character.elapsedTime + dt
    -- Si ha pasado el tiempo de un frame, avanzar al siguiente frame
    if character.elapsedTime >= character.timePerFrame then
        character.currentFrame = (character.currentFrame + 1) % character.totalFrames
        character.elapsedTime = 0 -- Reiniciar el contador
    end
end

function spawnEnemy()
    local newEnemy = {
        x = love.math.random(0, love.graphics.getWidth()),
        y = -50, -- Aparece arriba de la pantalla
        width = 32, -- Ancho del enemigo
        height = 32, -- Altura del enemigo
        speed = 50, -- Velocidad de movimiento del enemigo
        currentFrame = 0,
        totalFrames = 4,
        timePerFrame = 0.2,
        elapsedTime = 0
    }
    table.insert(enemies, newEnemy) -- Añadir el nuevo enemigo a la lista
end

function checkCollision(a, b)
    -- Función para comprobar colisiones entre dos objetos con hitbox rectangulares
    return a.x < b.x + b.width and
           a.x + a.width > b.x and
           a.y < b.y + b.height and
           a.y + a.height > b.y
end

function love.draw()
      -- Dibujar la animación del jugador
      love.graphics.draw(sprites[player.currentFrame], player.x, player.y)
    
      -- Dibujar el rectángulo de colisión del jugador (en color verde)
      love.graphics.setColor(0, 255, 0) -- Color verde
      love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
      
      -- Restaurar el color por defecto
      love.graphics.setColor(255, 255, 255)
  
      -- Dibujar la animación de los enemigos y sus rectángulos de colisión
      for _, enemy in ipairs(enemies) do
          love.graphics.draw(spritesEnemigos[enemy.currentFrame], enemy.x, enemy.y)
          
          -- Dibujar el rectángulo de colisión de cada enemigo (en color rojo)
          love.graphics.setColor(255, 0, 0) -- Color rojo
          love.graphics.rectangle("line", enemy.x, enemy.y, enemy.width, enemy.height)
          
          -- Restaurar el color por defecto
          love.graphics.setColor(255, 255, 255)
      end
end
