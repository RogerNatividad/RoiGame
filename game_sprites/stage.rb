class Stage
  
  
  ROWS = 6
  COLS = 8
  MINLEFT = 80
  MINTOP = 20      #this is top 
  
   BRICKS = [
     [0,1,2,2,2,2,1,0,
     1,2,1,3,3,1,2,1,
     0,2,1,4,4,1,2,0,
     3,2,1,0,0,1,2,3,
     3,4,2,2,2,2,4,3,
     0,0,1,1,1,1,0,0
    ],
    [0,1,1,1,1,1,1,0,
     0,0,1,3,3,1,0,0,
     4,3,0,3,3,0,3,4,
     4,0,1,0,0,1,0,4,
     0,0,3,3,3,3,0,0,
     0,0,0,1,1,0,0,0
    ],
    [4,2,2,2,2,2,2,4,
     2,0,1,3,3,1,0,2,
     2,0,0,3,3,0,0,2,
     2,0,2,2,2,2,0,2,
     1,0,3,3,3,3,0,1,
     1,1,1,1,1,1,1,1
    ],
     [4,4,4,4,4,4,4,4,
     0,0,0,0,0,0,0,0,
     2,2,2,2,2,2,2,2,
     2,0,2,0,0,2,0,2,
     3,3,3,3,3,3,3,3,
     1,1,1,1,1,1,1,1
    ],
    [3,3,3,1,1,1,2,0,
     3,0,3,1,0,1,2,0,
     3,3,3,1,0,1,2,0,
     3,3,0,1,0,1,2,0,
     3,0,3,1,0,1,2,0,
     3,0,3,1,1,1,2,0
    ]
    ]
    
 #   MY_BRICKS = []
  attr_accessor :my_bricks
  attr_accessor :stick, :ball
  attr_accessor :image_footer, :image_lives
  attr_accessor :gosu, :game_over
  
  
  STAGE_COLOUR = 0xffffffff  
  
  def initialize(gosu)
    self.gosu = gosu
    #self.mode = mode
    self.my_bricks =  []
    # live
    @level = 1	
    @HiScore = 0
    @win = false
   
   self.stick = Stick.new(@gosu, self)
   self.ball = Ball.new(@gosu, self)
   
   self.image_footer = Gosu::Image.new(@gosu, MEDIA + 'form.png', false, 0, 0, 800,80 )  
   self.image_lives = Gosu::Image.new(@gosu, MEDIA + 'live.png', false, 0, 0, 18,18 )  

   self.mapear!
   
  # self.game_over = GameOver.new(@gosu, get_points.to_s)   
    @Sound = [
    Gosu::Sample.new(@gosu, MEDIA + 'click.wav'), # Sound
    Gosu::Sample.new(@gosu, MEDIA + 'power_up_04.wav')
    ]
    end
    
    def update
	    if  not @gosu.current_state.game_over  
	    
		   if @gosu.current_state.init  
		     
				unless @gosu.current_state.pause
				     self.ball.update
				     deletbrick
				       @gosu.current_state.update_score( get_points)
				       
				     #game_over if ballOut 
				     check_lives
				     nextLevel unless bricksOut
			     end
		   #  else
				#self.game_over = GameOver.new(@gosu, get_points.to_s)   			
		   end
	     else
			
		@gosu.next_state(:game_over, get_points.to_s, @win)
	     end
	     
     end
     
      def draw
		self.draw_brick   
		self.draw_stick
		self.draw_ball
		 self.image_footer.draw(0, 520, StageLayer)
		 draw_lives
		# self.image_lives.draw(700, 540, LivesLayer)
		# draw_stage
	
     end

def draw_lives 
	i = 0
	left_x = 700
	while i< @gosu.current_state.lives
		self.image_lives.draw(left_x + ( i * 22), 540, LivesLayer)
		i+=1
	end	
end

# check live for Game Over
def check_lives
	 if ballOut 
		  @gosu.current_state.lives-=1
		  if @gosu.current_state.lives == 0
			  game_over
		  else
			  @gosu.current_state.update_msj('Presiona "Barra" para empezar')
			  @gosu.current_state.init = false
			self.stick = Stick.new(@gosu, self)
			self.ball = Ball.new(@gosu, self)
		  end
	end
	  
end



=begin
*****************************************************************************
    def draw_stage
	@gosu.draw_quad(@x_coord,           @y_coord,           STAGE_COLOUR,
                    @x_coord + @width,  @y_coord,           STAGE_COLOUR,
                    @x_coord,           @y_coord + @height, STAGE_COLOUR,
                    @x_coord + @width,  @y_coord + @height, STAGE_COLOUR,
                    StageLayer)
		    
	end
*****************************************************************************	
=end	    


	def draw_stick 
		self.stick.draw
	end
	
	def draw_ball
		self.ball.draw
	end
	
	def draw_brick
		for brick in self.my_bricks		
			brick.draw if brick != nil
		end
	end
	
	def mapear!
	self.my_bricks = []	
		
	  width = 80
	  height = 20
	  
	  color = nil
	  mi_brick = BRICKS[@level - 1]
	  i = 0 
	  j = 0
	 while i < ROWS 
	   while j < COLS 		
		unless mi_brick[(i* COLS) + j]  == 0 
	         left = MINLEFT + ( j * (width + 1) )
		 top = MINTOP + ( i  * (height +1 ))
		 
		color = mi_brick[(i* COLS) + j] 
		 
		self.my_bricks.push(Brick.new(@gosu, color, left, top, width, height))		
		end
	
		j+=1
	   end
	   j = 0 
	   i+=1
	end
	end


	def is_legal?(offset)
		legal = true
		if (offset[0] + @stick.x) > (@gosu.width - @stick.width )
			legal = false
		end
		if  ( @stick.x + offset[0] ) < 0
			legal = false
		end
		
		legal
	end
	
	# Delete the bricks
	def deletbrick	  	
		i = 0
		num = self.my_bricks.length
		 while i < num
			if  self.my_bricks[i] != nil
				if self.my_bricks[i].broken	
					self.my_bricks[i] = nil
					 @Sound[0].play
				end
			end
			i  +=  1
		 end
	end
	
	# Get the All Points
	def get_points
		points = 0 + @HiScore
		
		i = 0
		num = self.my_bricks.length
		 while i < num
			if  self.my_bricks[i] == nil
			#	if MY_BRICKS[i].broken					
					points += Brick::POINTS 
			#	end
			end
			i  +=  1
		end
		points
	end

 
	# CHECK SPRITES
	 def  checkToo( obj, x,y,width,height)
		( obj.y  <  ( y + height ) && (obj.y + obj.height > y) && (obj.x < x + width)  && (obj.x + obj.width > x)  )	  	  
	
	end
    
	def cheks(x,y,width,height)
	     ver = false
	     ver |=checkStick(x,y,width,height)
	     ver |=checkBrick(x,y,width,height)
	      ver
	end
    
	def checkStick(x,y,width,height)
		checkToo(@stick, x,y,width,height)
	end
    
       def checkBrick ( x,y,width,height)
	    hit = false
    	   for brick in self.my_bricks
		if  brick != nil
			if checkToo(brick, x,y,width,height)
				brick.broken = true # True
				hit = true 
			end
		
		end
	   end
	 hit
    
       end
       
       # Next level
       def nextLevel
	       @level += 1
	       #
	       @gosu.current_state.update_level( @level )	
	       
	       @HiScore += get_points
	       @Sound[1].play
	       # Check finish
	       if  @level == BRICKS.length + 1	      
			@win = true
		       game_over
		else
			       
	         @gosu.current_state.update_msj('Presiona "Barra" para empezar')
			  @gosu.current_state.init = false
			self.stick = Stick.new(@gosu, self)
			self.ball = Ball.new(@gosu, self)
			mapear!
	       end
	       
       end
       

	# Check  if the ball is height of window
	def ballOut
	    (@ball.height + @ball.y) == (@gosu.height - @ball.hwin)
	    
    end
    
    def bricksOut
		any = false
		
		i = 0
		num = self.my_bricks.length
		 while i < num
			unless self.my_bricks[i] == nil
				any = true
			end
			i  +=  1
		end
		any
    end
    
    
    
      def game_over
	@gosu.caption = "Game Over!"
	@gosu.current_state.game_over = true
      end
	    
end
    


     