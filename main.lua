--[[
local anim8 = require 'anim8'

function love.load()
 image = love.graphics.newImage('assets/gfx/walk.png')

                          -- frame, image,    offsets, border
 local g32 = anim8.newGrid(175,329, 700,329,   0,0,     0)

                     -- type    -- frames                   --default delay
hero = anim8.newAnimation(g32('1-4',1),              1)




end

function love.update(dt)
	hero:update(dt)
	end

function love.draw()
	hero:draw(   image, 100, 200)
end
]]



love.window.setMode(1920,1080)
love.window.setTitle('Windfield ')
Camera = require "lib/camera"
   wf = require('lib/windfield')
  world = wf.newWorld(0,0,true)
local background = love.graphics.newImage('assets/gfx/background.png');
function love.load()

    require("player")
    cam = Camera()
    world:addCollisionClass('Platform')
   world:addCollisionClass('Button')
    --create the ground
    local rectangle = world:newRectangleCollider( 0,love.graphics.getHeight(), 512,100 )
    rectangle:setType('static')
    rectangle:setCollisionClass('Platform')
    dx1 = 500 dy1 = -200
    cam:lookAt(player.collider:getX()+dx1,player.collider:getY()+dy1)


button = world:newRectangleCollider(960, 540, 96, 96)
    button:setCollisionClass("Button")
    button:setType('static')

end

function love.update(dt)
world:update(dt)
player:update(dt)
   local dx = player.collider:getX() - cam.x
   local dy = player.collider:getY() - cam.y
   local cx1,cy1 = player.collider:getPosition()
  -- local vx,vy = Body:getLinearVelocity( )
    ax=80 ay=80
  if cy1 + dy1>cam.y+ay then
cam:move(0, 3.5)  end
 if cy1 + dy1 <cam.y-ay then
cam:move(0, -3.5)  end
if cx1+dx1>cam.x+ax then
cam:move(3.5, 0)  end
 if cx1+dx1<cam.x-ax then
cam:move(-3.5, 0)  end


   
   
end

function love.draw()
  cam:attach()
  a=400 player:draw()
  ax1,ay1=player.collider:getPosition()
   love.graphics.print("player.x = "..ax1, a ,a - 50,0,4,4)
   love.graphics.print("player.y = "..ay1, a ,a - 100,0,4,4)
   love.graphics.print("cam.x = "..cam.x, a,a - 200,0,4,4)
   love.graphics.print("cam.y = "..cam.y, a,a - 250,0,4,4)
   world:draw()
  

cam:detach()
end

function love.keypressed(key) 
   if love.keyboard.isDown("escape") then
     love.event.quit("quit")
    end
end