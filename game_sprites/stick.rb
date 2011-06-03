class Stick
   attr_accessor :x, :y
   attr_accessor :width, :height
   attr_accessor :speed
   
   attr_accessor :stick, :stage
   attr_accessor :gosu
   
   
  def initialize(gosu,stage)
    self.gosu = gosu
     self.stage  = stage
    
   self.width =  180
   self.height = 15

   self.x = (self.gosu.width/2)  - (self.width/2)
   self.y =500	
    
    self.stick = Gosu::Image.new(@gosu, MEDIA + 'stick.png', true, 0, 0, @width , @height)
    
    self.speed = 10
    
  end
    def update
  
  end
  
  def draw
	self.stick.draw(@x,@y, StickLayer)
  end

    def move(offset)

	if self.stage.is_legal?(offset)
	      self.x += offset[0]	     
	  #      if offset[1] > 0
	   #        self.stage.set_tick
	   #     end
	end
	     

    end
  
 
  
  
  end