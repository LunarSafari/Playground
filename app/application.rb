require 'opal'
require 'twitch'
require_relative 'player'

include Twitch

canvas = `document.querySelector('#canvas')`
canvas = Canvas.new(canvas, width: 800, height: 600)

game = Game.new(canvas)
game.loop!


def load_from_src src
  image = `new Image`
  image.JS[:src] = src
  image
end

$image_object = load_from_src '/russian_f1.png'


player = Player.new(Vector[100, 100])
game.register player
