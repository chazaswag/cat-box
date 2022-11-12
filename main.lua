local love = require "love"

math.randomseed(os.time())
_G.Player = {
    x=390,
    y=250,
    sprite = love.graphics.newImage("sprite/entity.png"),
}
local Game ={
    score = -1,
    kill=false,
    play=true
}
local Shield ={
    x=-10000,
    y=-10000,
    sprite = {
        Y = love.graphics.newImage("sprite/shieldY.png"),
        X = love.graphics.newImage("sprite/shieldX.png"),
    },
    direction={
        Down =false,
        Up=false,
        Right=false,
        Left=false,
    },
}
local Pellet = {
 dice= math.random(1, 4),
    x=0,
    y=0,
  radius=10,
  level = 5,
  restart=false,
  amount= 1,
}

function love.load()
    love.window.setTitle("cat.box") 
    love.mouse.setVisible(false)
    Pellet.restart =true
end

function love.update()
    if Pellet.restart == true then
        if Pellet.dice == 1 then
            Pellet.x = Player.x+500
            Pellet.y = Player.y
            Pellet.restart=false
            Game.score = Game.score +1
        elseif Pellet.dice == 2 then
            Pellet.x = Player.x
            Pellet.y = Player.y+500
            Pellet.restart=false
            Game.score = Game.score +1
        elseif Pellet.dice == 3 then
            Pellet.x = Player.x
            Pellet.y = Player.y-500
            Pellet.restart=false
            Game.score = Game.score +1
        else
            Pellet.x = Player.x-500
            Pellet.y = Player.y
            Pellet.restart=false
            Game.score = Game.score +1
        end 
    end
    if Pellet.x  == Shield.x then
        Pellet.dice= math.random(1, 4)
        Pellet.restart=true
    elseif Pellet.y == Shield.y then
        Pellet.dice= math.random(1, 4)
        Pellet.restart=true
    end
    if Shield.x == Player.x then
        Game.kill = true
        Game.play = false
    end 
    if love.keyboard.isDown("d") then
        Shield.direction.Right = true
        Shield.direction.Left =false
        Shield.direction.Up =false
        Shield.direction.Down =false
        Shield.x = Player.x+80
    end
    if love.keyboard.isDown("a") then
        Shield.direction.Right = false
        Shield.direction.Left =true
        Shield.direction.Up =false
        Shield.direction.Down =false
        Shield.x = Player.x-40
    end
    if love.keyboard.isDown("w") then
        Shield.direction.Right = false
        Shield.direction.Left =false
        Shield.direction.Up =true
        Shield.direction.Down =false
        Shield.y =Player.y-40
    end
    if love.keyboard.isDown("s") then
        Shield.direction.Right = false
        Shield.direction.Left =false
        Shield.direction.Up =false
        Shield.direction.Down =true
        Shield.y =Player.y+80
    end

    if Player.x+25 - Pellet.x  > 0 then
        Pellet.x = Pellet.x + Pellet.level
    elseif Player.x+25 - Pellet.x <0 then
        Pellet.x = Pellet.x - Pellet.level
    end

        if Player.y+25 - Pellet.y  > 0 then
            Pellet.y = Pellet.y + Pellet.level
        elseif Player.y+25 - Pellet.y <0 then
            Pellet.y = Pellet.y - Pellet.level
        end
    if Player.x+25 == Pellet.x and Player.y+25 == Pellet.y  then
    Game.kill = true
    end
end
function love.draw()
if Game.kill ==true then
    love.graphics.printf(
        "You lost.",
        love.graphics.newFont(16), --sets the font size and 
         10,-- x position
         love.graphics.getHeight() -30, -- the y position (this puts it at the bottom of the screen)
        love.graphics.getWidth()
    )
else
    love.graphics.printf(
        "Score :"..  Game.score, -- function to get the fps
        love.graphics.newFont(16), --sets the font size and 
         10,-- x position
         love.graphics.getHeight() -30, -- the y position (this puts it at the bottom of the screen)
        love.graphics.getWidth()-- how far it should go before wrapping text
       )

    love.graphics.draw(Player.sprite, Player.x, Player.y)
   if Shield.direction.Right == true then
    love.graphics.draw(Shield.sprite.Y,Player.x+80, Player.y)
   end
   if Shield.direction.Left == true then
    love.graphics.draw(Shield.sprite.Y,Player.x-40, Player.y)
   end
   if Shield.direction.Up == true then
    love.graphics.draw(Shield.sprite.X,Player.x, Player.y-40)
   end
   if Shield.direction.Down == true then
    love.graphics.draw(Shield.sprite.X,Player.x, Player.y+80)
   end
   love.graphics.circle("fill", Pellet.x, Pellet.y, Pellet.radius)
end
end