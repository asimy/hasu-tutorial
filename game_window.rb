require 'gosu'
require 'hasu'

Hasu.load 'player.rb'
Hasu.load 'star.rb'
Hasu.load 'zorder.rb'

class GameWindow < Hasu::Window
  EXAMPLE_PATH = '/Users/glenab/.rbenv/versions/2.1.4/gemsets/gosu-tutorial/gems/gosu-0.8.5/examples/media/'
  WIDTH = 800
  HEIGHT = 600
  
  def initialize(width = WIDTH, height = HEIGHT, full = false)
    super
  end
  
  def reset
    @player = Player.new(self)

    self.caption = "Glen's Hasu Tutorial Game"
    
    @background_image = Gosu::Image.new(self, EXAMPLE_PATH + 'Space.png', true)
    
    @player.warp(self.width/2, self.height/2)
    
    @star_anim = Gosu::Image::load_tiles(self, EXAMPLE_PATH + "Star.png", 25, 25, false)
    
    @stars = []
    
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
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
    @player.collect_stars(@stars)
    
    if rand(100) < 4 && @stars.size < 25 then
      @stars.push(Star.new(@star_anim))
    end
  end
  
  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @player.draw
    @stars.each { |star| star.draw }
    @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
  end
  
  def button_down(id)
    close if id == Gosu::KbEscape
  end
  
end

window = GameWindow.run