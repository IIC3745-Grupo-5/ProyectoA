# frozen_string_literal: true

require_relative './board'
require_relative './constants/difficulty_type'
require 'highline/import'

# Class that creates an object representing the game
class Game
  def initialize
    @board = nil
    @playing = true
    choose do |menu|
      menu.prompt = 'Hello! Choose your difficulty:'
      menu.choice(:Begginer) { @board = Board.new(DifficultyType::BEGGINER) }
      menu.choice(:Intermediate) { @board = Board.new(DifficultyType::INTERMEDIATE) }
      menu.choice(:Expert) { @board = Board.new(DifficultyType::EXPERT) }
    end
    @board.print
    start_game
  end

  def start_game
    loop do
      choose_move
      @playing && @board.print
      break unless @playing
    end
    puts 'Good Bye!'
  end

  def choose_move
    choose do |menu|
      menu.prompt = 'What do you want to do?'
      menu.choice(:'Discover a cell') do
        y_coordinate = ask 'In which row?: '
        x_coordinate = ask 'In which column?: '
        valid = @board.discover_cell(x_coordinate.to_i, y_coordinate.to_i)
        if valid == "flagged"
          say("Cannot discover a flagged cell")
        end
      end
      menu.choice(:'Flag or unflag a cell') do # TODO extract duplicate code
        y_coordinate = ask 'In which row?: '
        x_coordinate = ask 'In which column?: '
        valid = @board.flag_cell(x_coordinate.to_i, y_coordinate.to_i)
        if valid == "discovered"
          say("Cannot flag a discovered cell")
        end
      end
      menu.choice(:Quit) { @playing = false }
    end
  end
end
