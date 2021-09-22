# frozen_string_literal: true

require_relative './board'
require_relative './constants/difficulty_type'
require 'highline/import'

# Toda esta lógica se tiene que mover a la clase Game
board = Board.new(DifficultyType::BEGGINER)
board.print

playing = true
loop do
  choose do |menu|
    menu.prompt = 'What do you want to do?'
    menu.choice(:'Discover a cell') {
      y_coordinate = ask 'In which row?: '
      x_coordinate = ask 'In which column?: '
      board.discover_cell(x_coordinate.to_i, y_coordinate.to_i)
    }
    menu.choice(:'Flag or unflag a cell') { say('Not implemented yet...') }
    menu.choice(:Quit) { playing = false }
  end
  playing && board.print
  break unless playing
end

puts 'Good Bye!'
