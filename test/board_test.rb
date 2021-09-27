# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board'
require_relative '../lib/constants/level'
require_relative '../lib/constants/cell_type'
require_relative '../lib/constants/dimensions'
require 'test/unit'

class BoardTest < Test::Unit::TestCase
  def setup
    @difficulty_level = Level::BEGGINER
    @board = Board.new(@difficulty_level)
  end

  def test_discover_flagged_cell
    @board.matrix[0][0].flagged = true
    output = @board.discover_cell(0, 0)
    assert_equal('flagged', output)
  end

  def test_discover_unflagged_cell
    @board.discover_cell(0, 0)
    discovered = @board.matrix[0][0].discovered
    assert_equal(true, discovered)
  end

  def test_flag_discovered_cell
    @board.matrix[0][0].discovered = true
    output = @board.flag_cell(0, 0)
    assert_equal('discovered', output)
  end

  def test_toggle_flag_undiscovered_cell
    [true, false].each do |expected|
      @board.flag_cell(0, 0)
      flagged = @board.matrix[0][0].flagged
      assert_equal(expected, flagged)
    end
  end

  def test_discover_empty_neighbors
    (0..3).each do |col|
      (0..3).each do |row|
        if col == 3 || row == 3
          @board.matrix[col][row].type = CellType::SAFE
          @board.matrix[col][row].adjacent_mines = 1
        else
          @board.matrix[col][row].type = CellType::SAFE
          @board.matrix[col][row].adjacent_mines = 0
        end
      end
    end

    @board.discover_cell(0, 0)
    (0..2).each do |col|
      (0..2).each do |row|
        discovered = @board.matrix[col][row].discovered
        assert_equal(true, discovered)
      end
    end
  end

  def test_print
    width = Dimensions::BOARD[@difficulty_level][0]
    height = Dimensions::BOARD[@difficulty_level][1]
    expected = []
    (0..height).each do |row_index|
      expected << [row_index] + [CellType::HIDDEN] * (width + 1)
    end
    output = @board.print
    assert_equal(expected, output)
  end
end
