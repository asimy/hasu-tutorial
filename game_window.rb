require 'hasu'
Hasu.load 'player.rb'

class GameWindow < Hasu::Window

  def initialize(width = 800, height = 600, full = false)
    super
  end
  
  def reset
    self.caption = "Glen's Gosu Tutorial Game"
    
    @background_image = Gosu::Image.new(self, example_path + 'Space.png', true)
    
    @player.warp(self.width/2, self.height/2)
    @player = Player.new(self)
  end
  
  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft
      @player.turn_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight
      @player.turn_right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0
      @player.accelerate
    end
    
    @player.move
  end
  
  def draw
    @player.draw
    @background_image.draw(0, 0, 0)
  end
  
  def button_down(id)
    close if id == Gosu::KbEscape
  end
  
  def self.example_path
    '/Users/glenab/.rbenv/versions/2.1.4/gemsets/gosu-tutorial/gems/gosu-0.8.5/examples/media/'
  end
  
  def example_path
    GameWindow::example_path
  end
  
end

window = GameWindow.run