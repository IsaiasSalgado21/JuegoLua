--suma con variables
a=5
b=8
print(a+b)
image = love.graphics.newImage("sprites/sprite_1.png")

-- juntar strings con variables de tipo texto
nombre = "isaias salgado"
edad = "22"
print("hola, mi nombre es " .. nombre .. " mi edad es de " .. edad) 
--[[comentario 
de varias 
lineas en lua]]
print("----------------------------")
-- funciones pasar un parametro 
function saludo(num)
    print("hola, me gusta el numero "..num)
end

saludo(23)
saludo(24)
saludo(67)
-- funcion que devulve un valor con return
function dameCinco()
    return 5
end
cinco = dameCinco()
print(cinco)

--funcion que recibe argumentos y regresa la suma
function suma(x, y)
    return x + y
end
print(suma(232,89))

print("----------------------------")

--[[funcion para dibujar un hola mundo en love2d
function love.draw()
    love.graphics.print("Hello World!", 400, 300)
    end]]

--[[funcion para dibujar un rectangulo con color por dentro
function love.draw()

    love.graphics.rectangle("fill", 100, 200, 50, 90)
end
]]



--funciones principales para el movimiento
function love.load()
    
   -- fruits{"manzana", "mandarinas"}
   
    x = 100
    y = 100
    --creamos la variable move para usar un tipo booleano en nuestro codigo
    move = true 
end
--con esta funcion se va a estar actualizando la coordenada x de nuestro rectangulo
--ahora vamos a usar tiempo delta (dt) para actualizar los fps de acuerdo al tiempo que se debe actualizar en
--todas las computadoras 

function love.update(dt)
--usaremos el if para evitar que salga el rectangulo de nuestra interfaz, ~= diferente de
--con la siguiente funcion haremos que se mueva con la flecha derecha, izquierda, arriba y abajo
    if love.keyboard.isDown("right")then
        x = x + 100 * dt
    elseif love.keyboard.isDown("left")then
        x = x - 100 * dt
    elseif love.keyboard.isDown("up") then
        y = y - 100 * dt
    elseif love.keyboard.isDown("down") then
        y = y + 100 * dt
    end

    
end
--funcion para dibujar un rectangulo con lineas de color
function love.draw()
    --love.graphics.rectangle("line", x, y, 200, 150)
    love.graphics.draw(image, x, y)
    love.graphics.rectangle("fill", 0, 50, 25, 200)
end

--[[
function love.load()

    --creamos un tabla de nombre fruits
    fruits = {"manzana", "mandarinas"}
    --insetamos una nueva fruta a la tabla fruits
    table.insert(fruits, "piña")
    for i=1,10 do
        print("hello", i)
    end
end
function love.update()

end
function love.draw()
    --aqui pintamos la tabla en la interfaz, llamando a cada variable contenida dentro de la tabla de forma individual
    love.graphics.print(fruits[1], 100, 100)
    love.graphics.print(fruits[2], 100, 125)
    love.graphics.print(fruits[3], 100, 150)
end
]]