# frozen_string_literal: true

require_relative './board'
require_relative './constants/level'
require 'highline/import'
require_relative './ui'

# Class that creates an object representing the game
class Game
  attr_reader :board, :playing

  def initialize(board = Board.new(Level::EXPERT))
    @board = board
    @playing = true
    @ui = Ui.new
  end

  def start_game
    choose do |menu|
      menu.prompt = 'Hello! Choose your difficulty:'
      menu.choice(:Begginer) { @board = Board.new(Level::BEGGINER) }
      menu.choice(:Intermediate) { @board = Board.new(Level::INTERMEDIATE) }
      menu.choice(:Experts) { @board = Board.new(Level::EXPERT) }
    end
    @board.print
    choose_move
  end

  def choose_move
    loop do
      choose do |menu|
        menu.prompt = 'What do you want to do?'
        show_choices(menu)
      end
      @playing && @board.print
      win_check
      break unless @playing
    end
    @ui.print_console('Good Bye')
  end

  def show_choices(menu)
    menu.choice(:'Discover a cell') do
      ask_choice('discover')
    end
    menu.choice(:'Flag or unflag a cell') do
      ask_choice('flag')
    end
    menu.choice(:Quit) { @playing = false }
  end

  def ask_coordinates
    y_coordinate = ask('In which row?: ', Integer) { |q| q.in = 0..@board.width }
    x_coordinate = ask('In which column?: ', Integer) { |q| q.in = 0..@board.width }
    [y_coordinate, x_coordinate]
  end

  def ask_choice(choice)
    y_coordinate, x_coordinate = ask_coordinates
    case choice
    when 'discover'
      valid = @board.discover_cell(x_coordinate.to_i, y_coordinate.to_i)
    when 'flag'
      valid = @board.flag_cell(x_coordinate.to_i, y_coordinate.to_i)
    end
    @ui.say("❗ Cannot #{choice} a #{valid} cell ❗") if %w[discovered flagged].include?(valid)
    @ui.say("❗ You don't have more flags ❗") if %w[no_flags].include?(valid)
    lose(y_coordinate.to_i, x_coordinate.to_i) if valid == 'explosion'
  end

  def lose(y_coordinate, x_coordinate)
    say('💥 You stepped on a MINE 💥')
    @board.explode_bomb(y_coordinate, x_coordinate)
    @board.show_bombs
    @board.print
    @ui.print_console('You lost :(')
    @playing = false
  end

  def win_check
    @board.matrix.each do |row|
      row.each do |cell|
        next unless cell.type == CellType::SAFE
        return true unless cell.discovered
      end
    end
    @ui.print_console('🏆 VICTORY! 🏆')
    @playing = false
  end
end
