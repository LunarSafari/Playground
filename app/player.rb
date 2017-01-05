class Player
  def initialize position
    @speed = 0.2
    @position = position
    @images = (0..3).map{|x| Image.new($image_object, [x * 32, 0], [32, 48]) }
    @draw_index = 0
  end

  def update dt
    velocity = Vector[0, 0]

    if Control.go_left?
      velocity += Vector[-1, 0]
    elsif Control.go_right?
      velocity += Vector[1, 0]
    end

    if Control.go_up?
      velocity += Vector[0, -1]
    elsif Control.go_down?
      velocity += Vector[0, 1]
    end

    @position += velocity.normalize * @speed * dt
  end

  def draw canvas
    canvas.draw_rect(@position, [10, 10])
    @draw_index = 0 if @draw_index == 4
    canvas.draw_image(@images[@draw_index], @position)
    @draw_index += 1
  end
end