class State
  
  
  def initialize(gosu)
    @gosu = gosu
    state_initialize
  end
  
  
  # Aqui deberia sobreescribir en la subclase como un initialize
  def state_initialize
  end
  
  
  def update
  end
  
  
  def draw
  end
  
  
  def button_down(id)
  end
  
  
  def button_up(id)
  end
  
  
end