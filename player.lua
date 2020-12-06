local anim8 = require('lib/anim8')
local spritesheet = love.graphics.newImage('assets/gfx/walk.png');
 local g32 = anim8.newGrid(175, 329, spritesheet:getWidth(), spritesheet:getHeight())
local score=0
local frase = ''
player = {
    spritesheet = spritesheet,
    x = 0,
    y = 0,
    width=175,
    height=329,
    speed = 210,
    isMoving = false,
    animations = {
      walkUp = anim8.newAnimation(g32('1-7',3),              0.1),
      walkDown = anim8.newAnimation(g32('1-7',1),              0.1),
      walkLeft = anim8.newAnimation(g32('1-7',2),              0.1),
      walkRight =  anim8.newAnimation(g32('1-7',2),              0.1)
    }
  }
  world:addCollisionClass('Player')
  player.collider = world:newRectangleCollider(0,0,player.width/2,player.height/2.5)
  player.collider:setCollisionClass('Player')
  player.animation = player.animations.walkDown -- player starts looking down
  player.collider:setFixedRotation( true )
  player.xk=0
function player:update(dt)
       if player.isMoving then
        player.animation:update(dt)
    end

 

    local vectorX = 0
    local vectorY = 0

 if love.keyboard.isDown("space") then
 	frase = 'space'
        player:interact()
    end
 
  if love.keyboard.isDown("s") then 
    player.animation = player.animations.walkDown
    vectorY=1 
    player.dir = "down"
  end
  if love.keyboard.isDown("a") then 
    player.animation = player.animations.walkLeft
    vectorX=-1 
    player.dir = "left"
  end
  if love.keyboard.isDown("d")  then
    player.animation = player.animations.walkRight 
    vectorX=1
    player.dir = "right"
    player.xk=player.xk+3.5
  end
   if love.keyboard.isDown("w") then
    player.animation = player.animations.walkUp 
    vectorY=-1
    player.dir = "up"
    
  end

player.collider:setLinearVelocity(vectorX * player.speed, vectorY * player.speed)

    -- Check if player is moving
    if vectorX == 0 and vectorY == 0 then
        player.isMoving = false
        player.animation:gotoFrame(7) -- go to standing frame
    else
        player.isMoving =  true
    end
end

function player:interact()

    local px, py = player.collider:getPosition()

    if player.dir == "right" then
        px = px + 60
    elseif player.dir == "left" then
        px = px - 60
    elseif player.dir == "up" then
        py = py - 60
    elseif player.dir == "down" then
        py = py + 60
    end
    local colliders = world:queryCircleArea(px, py, 40, {"Button"})
    if #colliders > 0 then
        score = score + 1
     end
end

function player:draw()
    local px,py = player.collider:getX(),player.collider:getY()-player.height/5
    -- sx represents the scale on the x axis for the player animation
    -- If it is -1, the animation will flip horizontally (for walking left)
    --player.animation:draw(player.spritesheet, player.x, player.y)
	local sx = 1
    if player.animation == player.animations.walkLeft then
        sx = -1
    end
 	 
 	love.graphics.print(frase)
    love.graphics.print(score)

	player.animation:draw(player.spritesheet, px, py, nil, sx, 1, player.width/2, player.height/2)
 
end