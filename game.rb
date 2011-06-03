class Game < Gosu::Window
	
	attr_accessor :current_state
	
	 STATE = {:main_menu    => "MainMenu.new(self)",
           :classic_game => "ClassicGame.new(self)",
	   :high_score => "HighScore.new(self)",
	   :game_over    => "GameOver.new(self,score,win)",
	   :close_game    => "CloseGame.new(self)"
	 }
	     
	def initialize
		super(800, 600, false)
		self.current_state = eval(STATE[:main_menu])
		@background_image = Gosu::Image.new(self, MEDIA + 'screen.png', false)
	end
	
	def update
		self.current_state.update
	end
	
	def draw
		self.current_state.draw
		@background_image.draw(0, 0, BackgroundLayer)
	end
	
	 def button_down(id)
		self.current_state.button_down(id)
	end
  
  
	def button_up(id)
		self.current_state.button_up(id)
	end
	
	def next_state(state, score, win)
		self.current_state = eval(STATE[state])
  
		rescue TypeError
		self.current_state = eval(STATE[:main_menu])
		print  "Estado no encontrado, Por defecto Main Menu"
  
	end
  
  
end
	
  