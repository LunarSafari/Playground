class Player
  def initialize position
    @speed = 0.2
    @position = position
    @images = (0..3).map{|x| Image.new($image_object, [x * 32, 0], [32, 48]) }
    @draw_index = 0
  end

  def update dt
    velocity = Vector[0, 0]

    if control.go_left?
      velocity += Vector[-1, 0]
    elsif control.go_right?
      velocity += Vector[1, 0]
    end

    if control.go_up?
      velocity += Vector[0, -1]
    elsif control.go_down?
      velocity += Vector[0, 1]
    end

    @position += velocity.normalize * @speed * dt
  end

  def draw canvas
    canvas.draw_indicator(@position, 15)
    @draw_index = 0 if @draw_index == 4
    canvas.draw_image(@images[@draw_index], @position, [0.5, 0.5])
    @draw_index += 1
  end

  def self.control
    @control ||= Control.new.define do
      def go_left?
        keydown[:ArrowLeft]
      end

      def go_right?
        keydown[:ArrowRight]
      end

      def go_up?
        keydown[:ArrowUp]
      end

      def go_down?
        keydown[:ArrowDown]
      end
    end
  end

  def control
    self.class.control
  end
end