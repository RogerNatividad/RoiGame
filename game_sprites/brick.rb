class Brick
	
   attr_accessor :x, :y
   attr_accessor :width, :height
   attr_accessor :broken
   attr_accessor :color
   
   attr_accessor :image
   attr_accessor :gosu
   
    COLOR_BRICK = {1 => 0,
	2 => 20, 
	3 => 40, 
	4 => 60, 
	5=>80 
     }
   
    POINTS = 30
   
	
  def initialize(gosu, color, left, top, width, height)
	  
   self.width =  width
   self.height = height

   self.x = left
   self.y =top	
   
   self.color =color     
   self.broken = false
     
   
    self.gosu = gosu
    self.image = Gosu::Image.new(@gosu, MEDIA + 'bricks.png', true, 0, COLOR_BRICK[@color], @width , @height )
  end
  
 def update
     
   
 end
 
  def draw
	self.image.draw(@x,@y, BlockLayer)
   
 end
 
 
 end