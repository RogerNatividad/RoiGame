class ClassicGameMode

  
  def initialize(gosu)
    @gosu  = gosu
    @stage = Stage.new(gosu)
    @song = Gosu::Song.new(@gosu, MEDIA + 'Transpose.mp3')
    @song.volume = 0.03
    @button_status  = false
    @last_button    = nil
    @button_counter = 90
    @button_press   = Gosu::milliseconds
    
  end
  

  def update
    @stage.update    
    if @button_status && (@button_press < Gosu::milliseconds)
      button_down(@last_button)
    end
  end


  def draw
    #@song.play unless @song.playing?
    @stage.draw
  end
  
    def button_down(id)
       

    
    @button_status = true
    @last_button   = id   
    @button_press  = Gosu::milliseconds + @button_counter
    
      if @button_counter > 10 || @button_counter == 0
	      if id == Gosu::KbLeft || id == Gosu::KbA
		  @stage.stick.move([-10, 0])
		end
	      
		if id == Gosu::KbRight || id == Gosu::KbD
		  @stage.stick.move([10, 0])
		end   
	      
       end
      #  @button_counter += 1
     end
     
     def button_up(id)
	@button_status = false
	@button_counter = 0
	
    end
  
  
end
  