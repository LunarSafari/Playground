require 'opal'
require 'twitch'
require_relative 'player'

include Twitch

canvas = `document.querySelector('#canvas')`
canvas = Canvas.new(canvas, width: 800, height: 600)

Game.init(canvas)
Game.loop!

Control.init

module ControlSchema
  def go_left?
    @keydown[:ArrowLeft]
  end

  def go_right?
    @keydown[:ArrowRight]
  end

  def go_up?
    @keydown[:ArrowUp]
  end

  def go_down?
    @keydown[:ArrowDown]
  end
end
Control.extend(ControlSchema)


def load_from_src src
  image = `new Image`
  image.JS[:src] = src
  image
end

$image_object = load_from_src '/russian_f1.png'


player = Player.new(Vector[10, 10])
Game.register player
