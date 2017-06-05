class Player
  def initialize position
    @speed = 0.15
    @position = position
    @image = Image.new($image_object)

    sprite_size = [32, 48]


    @image_array = @image.slice_into_array(4, 4)
    @images = @image_array[0]

    @animations = {
      down: Animation.new([@image_array[0][0]], 20),
      left: Animation.new([@image_array[1][0]], 20),
      right: Animation.new([@image_array[2][0]], 20),
      up: Animation.new([@image_array[3][0]], 20),
      going_down: Animation.new(@image_array[0], 20),
      going_left: Animation.new(@image_array[1], 20),
      going_right: Animation.new(@image_array[2], 20),
      going_up: Animation.new(@image_array[3], 20)
    }

    @state = :down
    @animation = @animations.values.first

    @draw_index = 0
  end

  def update dt
    velocity = Vector[0, 0]

    direction = control.direction
    case direction
    when :left
      velocity += Vector[-1, 0]
    when :right
      velocity += Vector[1, 0]
    when :up
      velocity += Vector[0, -1]
    when :down
      velocity += Vector[0, 1]
    end

    going direction
    @position += velocity.normalize * @speed * dt
  end

  def draw canvas
    canvas.draw_indicator(@position, 15)
    canvas.draw_image(@animation.next_image, @position, [0.5, 0.5])
    @draw_index %= 160
    @draw_index += 1
  end

  def self.control
    @control ||= Control.new.define do
      def direction
        (keydown[:ArrowLeft] && :left) || (keydown[:ArrowRight] && :right) || (keydown[:ArrowUp] && :up) || (keydown[:ArrowDown] && :down)
      end
    end
  end

  def control
    self.class.control
  end

  def going direction
    old_state = @state
    case direction
    when :left
      @state = :going_left
    when :right
      @state = :going_right
    when :up
      @state = :going_up
    when :down
      @state = :going_down
    else
      @state = @state.to_s.gsub('going_', '').to_sym
    end
    if old_state != @state
      @animation = @animations[@state]
      @animation.rewind
    end
  end
end