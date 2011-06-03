class Help
   attr_accessor :font, :font_pa,:txt_score, :txt_level, :msj_init, :msj_pause
   attr_accessor :gosu   	
   
   FONT_COLOUR = 0xff000000  
   FONT_PAUS_COLOUR = 0xffffcc00
   
   def initialize(gosu)
	    self.gosu = gosu
	    self.txt_score = 'Puntos :  0'
	    self.txt_level = 'Nivel     :  1'
	    self.msj_init = 'Presiona "Barra" para empezar'
	    self.msj_pause = ''
	      
	    self.font = Gosu::Font.new(@gosu, MEDIA + 'AldotheApache.ttf', 28)
	    self.font_pa = Gosu::Font.new(@gosu, MEDIA + 'AldotheApache.ttf', 55)
   end
   
  def update
  
  end
  def draw
	self.font.draw(@txt_score, 40, 540, FontLayer, 1, 1, FONT_COLOUR)
	self.font.draw(@txt_level, 40, 560, FontLayer, 1, 1, FONT_COLOUR)
	self.font.draw(@msj_init, 235, 560, FontLayer, 1, 1, 0xff666666)
	
	self.font_pa.draw(@msj_pause, 240, 300, FontLayer, 1, 1, FONT_PAUS_COLOUR)
end

def show_message_init(text)
	self.msj_init = ' ' + text.to_s  
end


  def update_score(text)
	  self.txt_score = 'Puntos :  ' + text.to_s     
  end
  
    def update_level(text)
	  self.txt_level = 'Nivel     :  ' + text.to_s     
  end
  
  def update_live
	  
  end
  def update_pause(text)
	self.msj_pause = ' ' + text.to_s   
  end

end
