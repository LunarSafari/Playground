class Player
  def initialize position
    @speed = 0.2
    @position = position
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
  end
end