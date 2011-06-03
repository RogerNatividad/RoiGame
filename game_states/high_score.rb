class HighScore < State
  
  
  def initialize(gosu)
    @gosu = gosu
    @gosu.caption = "High Scores"
    @font = Gosu::Font.new(@gosu, "Arial Black", 30) 
    @score_img= Gosu::Image.new(@gosu, MEDIA + 'score.png', false )  
    @score_list= Gosu::Image.new(@gosu, MEDIA + 'score_list.png', false , 0, 0, 660, 42)  
    
    @highscores = [YAML.load(File.open(MEDIA + HIGHSCORE, "r"))].flatten!
  end
  
  
  def update
  end
  
  
  def draw
	collec = []
	allscore = @highscores.flatten
	allscore.each { |el| collec.push(el.flatten)}
	datas= Hash[collec].sort {|a,b| a[1].to_i <=> b[1].to_i}
	 num = 0
        datas.reverse.each { |key, value|
        @font.draw(" #{num + 1}.             #{key}", 110, 50 * num + 135, FontLayer, 1, 1, 0xFF000000)
	 @font.draw("#{value}", 540, 50 * num + 135, FontLayer, 1, 1, 0xFF000000)
	 
	 @score_list.draw(70, 50 * num +130, StageLayer)
        num += 1 
      }
      #
      @score_img.draw(150,  30, StageLayer)
      
  end
  
  
  def button_down(id)
    if id == Gosu::KbEscape || id == Gosu::KbEnter || id == Gosu::KbReturn
      @gosu.next_state(:main_menu,nil,false)
    end
    
  end
  
end
