class MainMenu < State
	def state_initialize
	    @gosu.caption = "Juego RoiGame! - Menu Principal"
	    @options = [:classic_game, :high_score, :close_game]	    
	    @images = [
		Gosu::Image.new(@gosu, MEDIA + 'fondo_menu_jugar.png', false),
		Gosu::Image.new(@gosu, MEDIA + 'fondo_menu_puntajes.png', false),
		Gosu::Image.new(@gosu, MEDIA + 'fondo_menu_salir.png', false)
	      ]
	      
	    @current_option = 0
	    
	   @song = Gosu::Sample.new(@gosu, MEDIA + 'power_up_01.wav')
	end
	
	def draw
		@images[@current_option].draw(0, 0, UILayer)
	end
  
	def button_down(id)
    
		if id == Gosu::KbEscape
		      # @gosu.close
		end
		    
		if id == Gosu::KbDown
		      @current_option = (@current_option + 1) % @options.length
		      @song.play
		end
		    
		if id == Gosu::KbUp
		      @current_option = (@current_option - 1) % @options.length
		      @song.play	
		end
		    
		if id == Gosu::KbEnter || id == Gosu::KbReturn
		      @gosu.next_state(@options[@current_option], nil, false)
		end
    
	end
	
end

  