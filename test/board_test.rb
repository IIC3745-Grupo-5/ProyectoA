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
