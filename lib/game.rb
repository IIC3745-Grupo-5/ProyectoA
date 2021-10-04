# frozen_string_literal: true

require_relative './board'
require_relative './constants/level'
require_relative './ui'
require 'highline/import'

# Class that creates an object representing the game
class Game
  attr_reader :board, :playing

  def initialize(board = Board.new(Level::BEGGINER))
    @board = board
    @playing = true
    @ui = Ui.new
  end

  def difficulty_setting(difficulty)
    case difficulty
    when 'Begginer'
      @board = Board.new(Level::BEGGINER)
    when 'Intermediate'
      @board = Board.new(Level::INTERMEDIATE)
    when 'Expert'
      @board = Board.new(Level::EXPERT)
    end
  end

  def start_game(testing)
    testing.nil? && chosen_difficulty = @ui.ask_difficulty
    difficulty = chosen_difficulty || testing
    difficulty_setting(difficulty)
    @board.print
    testing.nil? && choose_move
  end

  def handle_choice(choice, testing = 'false')
    if %w[discover flag].include?(choice)
      make_choice(choice) if testing == 'false'
      @board.print
    else
      @playing = false
    end
  end

  def choose_move
    loop do
      choice = @ui.ask_choice
      handle_choice(choice)
      win_check
      break unless @playing
    end
    @ui.print_console('Good Bye')
  end

  def handle_valid(choice, x_coordinate, y_coordinate)
    case choice
    when 'discover'
      valid = @board.discover_cell(x_coordinate.to_i, y_coordinate.to_i)
    when 'flag'
      valid = @board.flag_cell(x_coordinate.to_i, y_coordinate.to_i)
    end
    valid
  end

  def make_choice(choice, x_coordinate = -1, y_coordinate = -1)
    y_coordinate, x_coordinate = @ui.ask_coordinates(@board.width) if x_coordinate == -1
    valid = handle_valid(choice, x_coordinate, y_coordinate)
    @ui.print_console("❗ Cannot #{choice} a #{valid} cell ❗") if %w[discovered flagged].include?(valid)
    @ui.print_console("❗ You don't have more flags ❗") if %w[no_flags].include?(valid)
    lose(y_coordinate.to_i, x_coordinate.to_i) if valid == 'explosion'
  end

  def lose(y_coordinate, x_coordinate)
    @ui.print_console('💥 You stepped on a MINE 💥')
    @board.explode_bomb(y_coordinate, x_coordinate)
    @board.show_bombs
    @board.print
    @ui.print_console('You lost 🙁')
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
