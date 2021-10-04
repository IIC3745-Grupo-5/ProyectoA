# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/constants/level'
require_relative '../lib/constants/cell_type'
require_relative '../lib/constants/dimensions'
require 'test/unit'

class GameTest < Test::Unit::TestCase
  def setup
    @game = Game.new
  end

  def test_win_condition
    @game.board.matrix.each do |row|
      row.each do |cell|
        cell.type = CellType::SAFE
        cell.discovered = true
      end
    end
    @game.win_check
    win = @game.playing
    assert_equal(false, win)
  end

  def test_flag
    @game.board.matrix.each do |row|
      row.each do |cell|
        cell.type = CellType::SAFE
        cell.discovered = false
      end
    end
    @game.make_choice('flag', 0, 0)
    assert_equal(true, @game.board.matrix[0][0].flagged)
  end

  def test_lose
    cell = @game.board.matrix[0][0]
    cell.type = CellType::MINE
    cell.discovered = false
    @game.make_choice('discover', 0, 0)
    assert_equal(false, @game.playing)
  end

  def test_difficulty_begginer
    @game.start_game('Begginer')
    area = @game.board.width * @game.board.height
    expected_dimensions = Dimensions::BOARD[Level::BEGGINER]
    expected = expected_dimensions[0] * expected_dimensions[1]
    assert_equal(expected, area)
  end

  def test_difficulty_intermediate
    @game.start_game('Intermediate')
    area = @game.board.width * @game.board.height
    expected_dimensions = Dimensions::BOARD[Level::INTERMEDIATE]
    expected = expected_dimensions[0] * expected_dimensions[1]
    assert_equal(expected, area)
  end

  def test_difficulty_expert
    @game.start_game('Expert')
    area = @game.board.width * @game.board.height
    expected_dimensions = Dimensions::BOARD[Level::EXPERT]
    expected = expected_dimensions[0] * expected_dimensions[1]
    assert_equal(expected, area)
  end

  def test_handle_choice_quit
    @game.choose_move('quit')
    assert_equal(false, @game.playing)
  end
end
