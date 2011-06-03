
class TextField < Gosu::TextInput

  INACTIVE_COLOR  = 0xcc666666
  ACTIVE_COLOR    = 0xccff6666
  SELECTION_COLOR = 0xcc0000ff
  CARET_COLOR     = 0xffffffff
  PADDING = 5
  
  attr_reader :x, :y
  
  def initialize(window, font, x, y)
    super()
    
    @window, @font, @x, @y = window, font, x, y
    self.text = "Click aqui para tu Nombre"
    @empty = 0
  end  

  def filter text
    text.upcase
  end
  
  def draw

if @window.text_input == self then
      background_color = ACTIVE_COLOR
      @empty += 1
       self.text = "" if @empty == 1
    else
      background_color = INACTIVE_COLOR
    end
=begin
    @window.draw_quad(x - PADDING,         y - PADDING,          background_color,
                      x + 300 + PADDING, y - PADDING,          background_color,
                      x - PADDING,         y + 25 + PADDING, background_color,
                      x + 300 + PADDING, y + 25 + PADDING, background_color, FontLayer)
    
=end    
    pos_x = x + @font.text_width(self.text[0...self.caret_pos])
    sel_x = x + @font.text_width(self.text[0...self.selection_start])

    if @window.text_input == self then
      @window.draw_line(pos_x, y,          CARET_COLOR,
                        pos_x, y + height, CARET_COLOR, FontLayer)
    end

    @font.draw(self.text, x, y, FontLayer)
  end

  def width
    @font.text_width(self.text)
  end
  
  def height
    @font.height
  end

  def under_point?(mouse_x, mouse_y)
    mouse_x > x - PADDING and mouse_x < x + width + PADDING and
      mouse_y > y - PADDING and mouse_y < y + height + PADDING
  end

  def move_caret(mouse_x)

    1.upto(self.text.length) do |i|
      if mouse_x < x + @font.text_width(text[0...i]) then
        self.caret_pos = self.selection_start = i - 1;
        return
      end
    end
    self.caret_pos = self.selection_start = self.text.length
  end
end