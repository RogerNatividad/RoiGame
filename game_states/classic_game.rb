require 'yaml'

class ClassicGame < State
  
  
  attr_accessor :game_over
  attr_accessor :score
  attr_accessor :lives
  
   attr_accessor :init, :pause
  
  def initialize(gosu)
    super(gosu)
    @gosu.caption = "Juego RoiGame!"
    self.game_over = false
    self.score     = 0
    
     self.lives = 3
    self.init = false
  self.pause = false
      
    @help = Help.new(gosu)
    @game = ClassicGameMode.new(gosu)
  end
  
  
  def update
    @game.update
  end
  
    def draw
  #  @gosu.caption = "Score: #{self.score}" unless self.game_over
    @help.draw	
    @game.draw
   end
   
   def update_score(points)
    self.score = points
    @help.update_score(self.score )
  end
  
   def update_level(level)
    #self.level = level
    @help.update_level(level )
  end
  
  def update_msj(text) #init 
	  @help.show_message_init(text)
  end
  
   
    def button_down(id)
	    
	    if id == Gosu::KbEscape
	        @gosu.next_state(:main_menu, nil, false)
	   end

	
	    if id == Gosu::KbSpace
		    update_msj('Presione "Escape" para volver al menu principal')
	        self.init = true
	    end
	  
		   if self.init 
			  if id == Gosu::KbP
				if self.pause == true
					 @help.update_pause('')
				self.pause = false
				else
					 @help.update_pause('Pausado')
				      self.pause = true
				end
			      
			   end
			   #
			unless self.pause 
			    unless self.game_over 
			       @game.button_down(id)
			    end
			end
		end
      end
  
  
	def button_up(id)
		@game.button_up(id)
	end
   
end
   