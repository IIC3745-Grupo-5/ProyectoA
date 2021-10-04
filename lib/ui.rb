# frozen_string_literal: true

require 'highline/import'

# Class who ui inputs and prints
class Ui
  @input = new

  class << self
    attr_reader :input
  end

  def ask_difficulty
    choose do |menu|
      menu.prompt = 'Hello! Choose your difficulty:'
      menu.choice(:Begginer) { return 'Begginer' }
      menu.choice(:Intermediate) { return 'Intermediate' }
      menu.choice(:Expert) { return 'Expert' }
    end
  end

  def ask_choice
    choose do |menu|
      menu.prompt = 'What do you want to do?'
      menu.choice(:'Discover a cell') { return 'discover' }
      menu.choice(:'Flag or unflag a cell') { return 'flag' }
      menu.choice(:Quit) { return 'quit' }
    end
  end

  # width is @board.width and height is @board.height
  def ask_coordinates(width, height)
    y_coordinate = ask('In which row?: ', Integer) { |q| q.in = 0..height }
    x_coordinate = ask('In which column?: ', Integer) { |q| q.in = 0..width }
    [y_coordinate, x_coordinate]
  end

  def print_console(input)
    puts input
  end
end
