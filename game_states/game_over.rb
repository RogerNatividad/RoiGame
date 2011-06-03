class GameOver
	
	attr_accessor :score, :win
	attr_accessor :gosu
	
	attr_accessor :font, :font_msj
	
	 FONT_COLOUR = 0xffffffff
	 FONT_COLOUR_PTS = 0xff000000
	 
	 
	def initialize(gosu, score, win)
		self.gosu = gosu
		self.score = score
		self.win = win ? "haz ganado" : "game over"
		self.font = Gosu::Font.new(@gosu, MEDIA + 'AldotheApache.ttf', 45)
		self.font_msj = Gosu::Font.new(@gosu, MEDIA + 'AldotheApache.ttf', 92)
		@cursor = Gosu::Image.new(@gosu, MEDIA + 'Cursor.png', false)
		
		@screen_gv= Gosu::Image.new(@gosu, MEDIA + 'game_over.png', false )  
		font = Gosu::Font.new(@gosu, MEDIA + 'AldotheApache.ttf', 36)
		@text_fields = Array.new(1) { |index| TextField.new(@gosu, font, 310, 380) }
	
	end
	
	def update
		
	end
	
	def draw 		
		@screen_gv.draw(0, 0, StageLayer)
	#	self.font.draw('Haz Perdido, Haz hecho :'   ,180, 140, FontLayer, 1, 1, FONT_COLOUR)	
		self.font_msj.draw( @win ,245,  50, FontLayer, 1, 1, FONT_COLOUR_PTS)	
		self.font.draw( @score + ' Puntos'   ,305, 260, FontLayer, 1, 1, FONT_COLOUR_PTS)	
		@text_fields.each { |tf| tf.draw }
		@cursor.draw(@gosu.mouse_x, @gosu.mouse_y, MouseLayer)
		
		
	end
	
	
	 def button_down(id)

	   if  id == Gosu::KbEnter || id == Gosu::KbReturn
			if @text_fields[0].text.strip == "Click aqui para tu Nombre" or @text_fields[0].text.strip  == ""
				# put message to check the input 
			else
			      submit_highscore(@text_fields[0].text, @score)
			      @gosu.next_state(:high_score, nil, false)
		      end
	    elsif id == Gosu::KbEscape then
	      if @gosu.text_input then
		@gosu.text_input = nil
	      else
		close
	      end
	    elsif id == Gosu::MsLeft then
	      @gosu.text_input = @text_fields.find{|tf| tf.under_point?(@gosu.mouse_x, @gosu.mouse_y) }
	      @gosu.text_input.move_caret(@gosu.mouse_x) unless @gosu.text_input.nil?
	    end
        end
       def button_up(id)
	
	end
	  def submit_highscore(nom, score)
	    data = { nom =>score }
	    
	    scores = []
	    scores << data
	    file = YAML.load(File.open(MEDIA + HIGHSCORE, "r"))
	    scores << file unless file == false
	   
	    file = File.new(MEDIA + HIGHSCORE, "w")
	    file << scores.flatten[0..9].to_yaml
	    file.close
	  end
	
end

	